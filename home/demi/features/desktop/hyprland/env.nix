{ ... }: {

  home.file.".config/uwsm/env".text = ''
      # --- Toolkit backend vars ---
      export GDK_BACKEND=wayland,x11,*
      export QT_QPA_PLATFORM=wayland;xcb
      # export SDL_VIDEODRIVER=wayland # cause nvidia driver problems
      # "_JAVA_AWT_WM_NONREPARENTING,1"

      # --- Qt vars ---
      export QT_AUTO_SCREEN_SCALE_FACTOR=1
      export QT_QPA_PLATFORMTHEME=qt5ct
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      # "OZONE_PLATFORM,wayland"

      export MOZ_ENABLE_WAYLAND=1 # enable for librewolf and firefox

      # --- Cursor ---
      export HYPRCURSOR_THEME=Bibata-Modern-Classic
      export HYPRCURSOR_SIZE=24
      export XCURSOR_THEME=Bibata-Modern-Classic
      export XCURSOR_SIZE=24 

      # █▄░█ █░█ █ █▀▄ █ ▄▀█
      # █░▀█ ▀▄▀ █ █▄▀ █ █▀█

      # See https://wiki.hyprland.org/Nvidia/
      export LIBVA_DRIVER_NAME=nvidia
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export GBM_BACKEND=nvidia-drm
      export __GL_VRR_ALLOWED=0
      # "WLR_DRM_NO_ATOMIC,1"
      # "WLR_NO_HARDWARE_CURSORS,1"
  '';

}
