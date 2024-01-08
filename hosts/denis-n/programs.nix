{pkgs, ...}: {
  programs = {
    command-not-found.enable = false;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
        acl
        libsodium
        util-linux
        xz
        systemd

        coreutils # For conda

        # glib

        # libbsd # For pulse secure
        # glib
        # gtkmm3
        # atkmm
        # glibmm
        # pangomm
        # gtk3
        # gnome2.pango
        # at-spi2-atk
        # cairo
        # cairomm
        # libsigcxx
        # gdk-pixbuf
        # webkitgtk
        # gnome.libsoup
      ];
    };

    ssh = {
      setXAuthLocation = true;
      forwardX11 = true;
    };

    zsh.enable = true;
    wireshark.enable = true;

    # sway = {
    #   enable = true;
    #   extraOptions = [
    #     "--verbose"
    #     "--debug"
    #     "--unsupported-gpu"
    #   ];
    # };
  };
}
