{...}: {
  services.kanata = {
    enable = true;
    keyboards.default = {
      config = ''
        (defsrc
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
          caps a    s    d    f    g    h    j    k    l    ;    '    ret
          lsft z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt           spc            ralt rmet rctl
        )

        (defvar
          tap 100
          hold 200
        )

        (deftemplate triple-tap-layer-switch (key layer-name)
          $key (tap-dance 200 (
            $key
            (macro $key $key)
            (layer-switch $layer-name)
          ))
        )

        (deflayermap (default)
          caps (tap-hold $tap $hold esc lctl)
          esc (tap-dance 200 (
            esc
            caps
          ))

          a (tap-hold $tap $hold a lalt)
          s (tap-hold $tap $hold s lmet)
          d (tap-hold $tap $hold d lsft)
          f (tap-hold $tap $hold f lctl)
          j (tap-hold $tap $hold j lctl)
          k (tap-hold $tap $hold k lsft)
          l (tap-hold $tap $hold l lmet)
          ; (tap-hold $tap $hold ; lalt)

          (template-expand triple-tap-layer-switch grv transparent)
        )


        (deflayermap (transparent)
          (template-expand triple-tap-layer-switch grv default)
        )
      '';
      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
