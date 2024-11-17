{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      openconnect

      teams-for-linux
      # webex
      # teams-for-poor-people
      remote-desktop-manager
    ];
  };
}

