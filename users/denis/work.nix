{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      openconnect

      teams-for-linux
      # teams-for-poor-people
      remote-desktop-manager
    ];
  };
}
