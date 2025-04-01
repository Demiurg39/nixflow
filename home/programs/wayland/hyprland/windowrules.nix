{...}: {
  wayland.windowManager.hyprland.settings = {
    # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
    # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█

    # See https://wiki.hyprland.org/Configuring/Window-Rules/

    windowrulev2 = [
      "opacity 0.95 0.90,class:^(LibreWolf)$"
      "opacity 0.90 0.80,class:^(kitty)$"
      "opacity 0.90 0.80,class:^(nemo)$"
      "opacity 0.90 0.80,class:^(org.gnome.FileRoller)$"
      "opacity 0.90 0.80,class:^(nwg-look)$"
      "opacity 0.90 0.80,class:^(qt5ct)$"
      "opacity 0.90 0.80,class:^(qt6ct)$"
      "opacity 0.90 0.80,class:^(kvantummanager)$"
      "opacity 0.90 0.80,class:^(org.pulseaudio.pavucontrol)$"
      "opacity 0.90 0.80,class:^(blueman-manager)$"
      "opacity 0.90 0.80,class:^(nm-applet)$"
      "opacity 0.90 0.80,class:^(nm-connection-editor)$"
      "opacity 0.90 0.80,class:^(polkit-gnome-authentication-agent-1)$"
      "opacity 0.90 0.80,class:^(org.freedesktop.impl.portal.desktop.gtk)$"
      "opacity 0.90 0.80,class:^(org.freedesktop.impl.portal.desktop.hyprland)$"
      "opacity 0.90 0.80,class:^([Ss]team)$"
      "opacity 0.90 0.80,class:^(steamwebhelper)$"
      "opacity 0.90 0.80,class:^(spotify)$"

      "opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$" # Clapper-Gtk
      "opacity 0.90 0.80,class:^(com.github.tchx84.Flatseal)$" # Flatseal-Gtk
      "opacity 0.90 0.80,class:^(hu.kramo.Cartridges)$" # Cartridges-Gtk
      "opacity 0.90 0.80,class:^(com.obsproject.Studio)$" # Obs-Qt
      "opacity 0.90 0.80,class:^(gnome-boxes)$" # Boxes-Gtk
      "opacity 0.90 0.80,class:^(WebCord)$" # WebCord-Electron
      "opacity 0.90 0.80,class:^(app.drey.Warp)$" # Warp-Gtk
      "opacity 0.90 0.80,class:^(net.davidotek.pupgui2)$" # ProtonUp-Qt
      "opacity 0.90 0.80,class:^(yad)$" # Protontricks-Gtk
      "opacity 0.90 0.80,class:^(io.github.alainm23.planify)$" # planify-Gtk
      "opacity 0.90 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$" # Upscaler-Gtk
      "opacity 0.90 0.80,class:^(com.github.unrud.VideoDownloader)$" # VideoDownloader-Gtk
      "opacity 0.90 0.80,class:^(io.gitlab.adhami3310.Impression)$" # Impression-Gtk
      "opacity 0.90 0.80,class:^(io.missioncenter.MissionCenter)$" # MissionCenter-Gtk
      "opacity 0.90 0.80,class:^(io.github.flattool.Warehouse)$" # Warehouse-Gtk

      "float,class:^(LibreWolf)$,title:^(Picture-in-Picture)$"
      "float,class:^(LibreWolf)$,title:^(Library)$"
      "float,class:^(steam)$,title:^([^Ssteam].*)$"
      "float,class:^(steam)$,title:^(Steam Settings)$"
      "float,class:^(xdg-desktop-portal-gtk)$,title:^(Pick game to add)$"
      "float,class:^(zenity)$,title:^(Winetricks - choose a wineprefix)$"
      "float,class:^(zenity)$,title:^(Winetricks - current prefix is \".*\")$"
      "float,class:^(net.lutris.Lutris)$,title:^(Log for .* \(wine\))$"
      "float,class:^(vlc)$"
      "float,class:^(eog)$"
      "float,class:^(kvantummanager)$"
      "float,class:^(qt[56]ct)$"
      "float,class:^(nwg-look)$"
      "float,class:^(org.gnome.FileRoller)$"
      "float,class:^(org.pulseaudio.pavucontrol)$"
      "float,class:^(blueman-manager)$"
      "float,class:^(nm-applet)$"
      "float,class:^(nm-connection-editor)$"
      "float,class:^(org.gnome.polkit-gnome-authentication-agent-1)$"
      "float,class:^(org.gnome.Settings)$"

      "float,class:^(Signal)$" # Signal-Gtk
      "float,class:^(com.github.rafostar.Clapper)$" # Clapper-Gtk
      "float,class:^(app.drey.Warp)$" # Warp-Gtk
      "float,class:^(net.davidotek.pupgui2)$" # ProtonUp-Qt
      "float,class:^(yad)$" # Protontricks-Gtk
      "float,class:^(org.gnome.Loupe)$" # Imageviewer-Gtk
      "float,class:^(io.github.alainm23.planify)$" # planify-Gtk
      "float,class:^(io.gitlab.theevilskeleton.Upscaler)$" # Upscaler-Gtk
      "float,class:^(com.github.unrud.VideoDownloader)$" # VideoDownloader-Gkk
      "float,class:^(io.gitlab.adhami3310.Impression)$" # Impression-Gtk
      "float,class:^(io.missioncenter.MissionCenter)$" # MissionCenter-Gtk

      "float,title:^(Open File)(.*)$"
      "float,title:^(Select a File)(.*)$"
      "float,title:^(Choose wallpaper)(.*)$"
      "float,title:^(Open Folder)(.*)$"
      "float,title:^(Save As)(.*)$"
      "float,title:^(Library)(.*)$"
      "float,title:^(File Upload)(.*)$"

      "center, title:^(Open File)(.*)$"
      "center, title:^(Select a File)(.*)$"
      "center, title:^(Choose wallpaper)(.*)$"
      "center, title:^(Open Folder)(.*)$"
      "center, title:^(Save As)(.*)$"
      "center, title:^(Library)(.*)$"
      "center, title:^(File Upload)(.*)$"
    ];

    # █░░ ▄▀█ █▄█ █▀▀ █▀█   █▀█ █░█ █░░ █▀▀ █▀
    # █▄▄ █▀█ ░█░ ██▄ █▀▄   █▀▄ █▄█ █▄▄ ██▄ ▄█

    layerrule = [
      "animation slide left, sideleft.*"
      "animation slide right, sideright.*"
      "blur, bar[0-9]*"
      "blur, cheatsheet[0-9]*"
      "blur, corner.*"
      "blur, dock[0-9]*"
      "blur, gtk-layer-shell"
      "blur, indicator.*"
      "blur, indicator.*"
      "blur, launcher"
      "blur, notifications"
      "blur, osk[0-9]*"
      "blur, overview[0-9]*"
      "blur, session"
      "blur, shell:*"
      "blur, sideleft[0-9]*"
      "blur, sideright[0-9]*"
      "ignorealpha 0.5, launcher"
      "ignorealpha 0.69, notifications"
      "ignorealpha 0.6, bar[0-9]*"
      "ignorealpha 0.6, cheatsheet[0-9]*"
      "ignorealpha 0.6, corner.*"
      "ignorealpha 0.6, dock[0-9]*"
      "ignorealpha 0.6, indicator.*"
      "ignorealpha 0.6, indicator.*"
      "ignorealpha 0.6, osk[0-9]*"
      "ignorealpha 0.6, overview[0-9]*"
      "ignorealpha 0.6, shell:*"
      "ignorealpha 0.6, sideleft[0-9]*"
      "ignorealpha 0.6, sideright[0-9]*"
      "ignorezero, gtk-layer-shell"
      "noanim, hyprpicker"
      # "noanim, indicator.*"
      # "noanim, noanim"
      "noanim, osk"
      "noanim, overview"
      "noanim, selection"
      "noanim, walker"
      "xray 1, .*"
    ];
  };
}
