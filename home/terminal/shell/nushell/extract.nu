# needs-directory: checks files inside archive
# and return bool value if inside archive exists root folder
def needs-directory [filepath: string] {
  match ($filepath | path parse | $in.extension) {
    "zip" => {
      let files_list = unzip -l $filepath | lines | skip 1 | first 3 | drop nth 1 | str downcase | to text | detect columns --guess
      if ($files_list.name | to text | str ends-with "/") {
        let root_dir = ($files_list.name | path split | get 0)

        if ($root_dir | length | $in == 1) {
          return false
        }
      }
      return true
    }
    "7z" => {
    # TODO: make this working
      let files_list = 7z l ($filepath) | lines | skip 18 | first 3 | drop nth 1 | str downcase | to text | detect columns --guess | $in.attr | str trim -c "." | $in.0 == "d"
    }
    "rar" => ()
    _ => ()
  }

}

# extract: extract archives (zip, rar, 7z, tar)
# with optional directory creation and dry-run
def --env extract [
    filepath: string, # path to archive
    --create-dir (-c), # create a new directory using filename and extract
    --dry (-d), # dry run
] {
    if ($filepath | path type | is-empty) {
        error make {
            msg: "file check failed"
            label: {
                text: "file does not exists"
                span: (metadata $filepath).span
            }
        }
    }

    let fn = $filepath | path parse
    if ($fn | is-empty) {
        error make {
            msg: "invalid filename format"
            label: {
                text: "only zip, rar, 7z, tar supported"
                span: (metadata $filepath).span
            }
        }
    }

    let name = $fn.stem
    let extension = $fn.extension
    let dir = ($name | str snake-case)

    let command = match ($extension) {
        "zip" => "unzip -a"
        "rar" => "unrar-free -x"
        "7z" => "7z x"
        "tar" => "echo 'Tar not supported currently'"
        _ => (error make {
            msg: "unsupported format"
            label: {
                text: "only zip, rar, 7z, tar supported"
                span: (metadata $extension).span
            }
        })
    }

    if $dry {
        if $create_dir {
            print $"Create \"($dir)\" directory"
        }
        print $"($command) ($filepath)"
        print ($name)
        return
    }

    if $create_dir and not ($extension == "rar") {
        mkdir $dir; cd $dir
        nu -c $"($command) ../($filepath)"
        cd ..
    } else {
        nu -c $"($command) ($filepath)"
    }
}
