{
  config,
  pkgs,
  ...
}: {
  systemd.services.auto-lock = {
    enable = true;
    path = with pkgs; [
      xautolock
      i3lock-fancy
    ];
    description = "xautolock enabler";
    serviceConfig = {
      User = "leo";
      Environment = "DISPLAY=:0";
      ExecStart = "${pkgs.xautolock}/bin/xautolock -time 5 -locker ${pkgs.i3lock-fancy}/bin/i3lock-fancy -detectsleep";
    };
  };
}
