{
  wayland.windowManager.hyprland.settings = {
    env = [
      # --- Hyprland basics vars ---
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"

      # --- Toolkit backend vars ---
      "GDK_BACKEND,wayland,x11,*"
      "QT_QPA_PLATFORM,wayland;xcb"
      # "SDL_VIDEODRIVER,wayland" # cause nvidia driver problems
      "CLUTTER_BACKEND,wayland"
      "_JAVA_AWT_WM_NONREPARENTING,1"

      # --- Qt vars ---
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      "OZONE_PLATFORM,wayland"
      "QT_QPA_PLATFORMTHEME,qt5ct"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

      # idk what is this
      "MOZ_ENABLE_WAYLAND,1"
      "MOZ_DISABLE_RDD_SANDBOX,1"
      "GDK_SCALE,1"
     
      # --- Cursor ---
      "HYPRCURSOR_THEME,Bibata-Modern-Classic"
      "HYPRCURSOR_SIZE,24"
      "XCURSOR_THEME,\"Bibata-Modern-Classic\""
      "XCURSOR_SIZE,24 "

      # █▄░█ █░█ █ █▀▄ █ ▄▀█
      # █░▀█ ▀▄▀ █ █▄▀ █ █▀█

      # See https://wiki.hyprland.org/Nvidia/
      "LIBVA_DRIVER_NAME,nvidia"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "__GL_VRR_ALLOWED,1"
      "GBM_BACKEND,nvidia-drm"
      # "WLR_DRM_NO_ATOMIC,1"
      # "WLR_NO_HARDWARE_CURSORS,1"
    ];
  };
}
