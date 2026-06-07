let carapace_completer = {|spans|
  # if the current command is an alias, get it's expansion
  let expanded_alias = (scope aliases | where name == $spans.0 | get -o 0 | get -o expansion)

  # overwrite
  let spans = (if $expanded_alias != null  {
    # put the first word of the expanded alias first in the span
    $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
  } else {
    $spans
  })

  carapace $spans.0 nushell ...$spans
    | from json
    | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
}

let fish_completer = {|spans|
    fish --command $"complete '--do-complete=($spans | str replace --all "'" "\\'" | str join ' ')'"
    | from tsv --flexible --noheaders --no-infer
    | rename value description
    | update value {|row|
      let value = $row.value
      let need_quote = ['\' ',' '[' ']' '(' ')' ' ' '\t' "'" '"' "`"] | any {$in in $value}
      if ($need_quote and ($value | path exists)) {
        let expanded_path = if ($value starts-with ~) {$value | path expand --no-symlink} else {$value}
        $'"($expanded_path | str replace --all "\"" "\\\"")"'
      } else {$value}
    }
}

def zoxide_completer [context: string] {
    let parts = $context | str trim --left | split row " " | skip 1 | each { str downcase }
    let completions = (
        ^zoxide query --list --exclude $env.PWD -- ...$parts
            | lines
            | each { |dir|
                if ($parts | length) <= 1 {
                    $dir
                } else {
                    let dir_lower = $dir | str downcase
                    let rem_start = $parts | drop 1 | reduce --fold 0 { |part, rem_start|
                        ($dir_lower | str index-of --range $rem_start.. $part) + ($part | str length)
                    }
                    {
                        value: ($dir | str substring $rem_start..),
                        description: $dir
                    }
                }
            })
    {
        options: {
            sort: false,
            completion_algorithm: substring,
            case_sensitive: false,
        },
        completions: $completions,
    }
}

# This completer will use carapace by default
let external_completer = {|spans|
    let expanded_alias = scope aliases
    | where name == $spans.0
    | get -o 0.expansion

    let spans = if $expanded_alias != null {
        $spans
        | skip 1
        | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        # carapace completions are incorrect for nu
        nu => $fish_completer

        # fish completes commits and branch names in a nicer way
        git => $fish_completer

        # use zoxide completions for zoxide commands
        __zoxide_z | __zoxide_zi => (zoxide_completer ($spans | str join ' ')),

        _ => $carapace_completer
    } | do $in $spans
}

mut current = (($env | default {} config).config | default {} completions)
$current.completions = ($current.completions | default {} external)
$current.completions.external = ($current.completions.external
| default true enable
| default { $external_completer } completer)

$env.config = $current
