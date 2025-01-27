# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{lib, ...}:
with lib.hm.gvariant; {
  dconf.settings = {
    # "org/gnome/desktop/background" = {
    #   picture-options = "zoom";
    #   picture-uri = "file:///home/denis/.config/background";
    #   picture-uri-dark = "file:///home/denis/.config/background";
    # };

    "org/gnome/desktop/input-sources" = {
      mru-sources = [(mkTuple ["xkb" "us"]) (mkTuple ["xkb" " ru"])];
      show-all-sources = false;
      sources = [(mkTuple ["xkb" "us"]) (mkTuple ["xkb" "ru"])];
      xkb-options = ["terminate:ctrl_alt_bksp" "grp:alt_shift_toggle" "caps:escape"];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "vimix-dark-compact-doder";
      icon-theme = "Vimix-Black-dark";
    };

    # "org/gnome/desktop/peripherals/keyboard" = {
    #   numlock-state = true;
    # };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.1;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      accel-profile = "flat";
      click-method = "areas";
      natural-scroll = true;
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [];
      show-desktop = ["<Super>d"];
      switch-applications = [];
      switch-applications-backward = [];
      switch-windows = ["<Alt>Tab"];
      switch-windows-backward = ["<Shift><Alt>Tab"];
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "icon:minimize,maximize,close";
    };

    # "org/gnome/mutter" = {
    #   dynamic-workspaces = true;
    #   edge-tiling = true;
    # };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 0.0;
      night-light-schedule-to = 0.0;
      night-light-temperature = mkUint32 3700;
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
      next = ["<Control><Super>Right"];
      play = ["<Control><Super>Down"];
      previous = ["<Control><Super>Left"];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Alt>space";
      command = "rofi -show drun";
      name = "rofi";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Control>Return";
      command = "wezterm-launch";
      name = "wezterm";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      idle-dim = false;
      power-button-action = "nothing";
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
    };

    # "org/gnome/shell" = {
    #   command-history = ["r"];
    #   disable-extension-version-validation = false;
    #   disable-user-extensions = false;
    #   disabled-extensions = ["user-theme@gnome-shell-extensions.gcampax.github.com" "remove-alt-tab-delay@vrba.dev"];
    #   enabled-extensions = ["aztaskbar@aztaskbar.gitlab.com" "appindicatorsupport@rgcjonas.gmail.com" "x11gestures@joseexposito.github.io" "autoselectheadset@josephlbarnett.github.com"];
    #   favorite-apps = ["firefox.desktop" "org.gnome.SystemMonitor.desktop" "teams-for-linux.desktop" "org.gnome.Nautilus.desktop" "spotify.desktop"];
    #   last-selected-power-profile = "power-saver";
    #   welcome-dialog-last-shown-version = "46.2";
    # };
  };
}

