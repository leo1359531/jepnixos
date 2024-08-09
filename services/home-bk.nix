{
  config,
  pkgs,
  ...
}: {
  # Home backup
  systemd = {
    timers.homebk = {
      wantedBy = ["timers.target"];
      after = ["multi-user.target"];
      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "24h";
        Unit = "homebk.service";
      };
    };

    services.homebk = {
      enable = false;
      path = [
        pkgs.bash
        pkgs.busybox
        pkgs.rclone
        pkgs.libnotify
      ];
      description = "home bk with rclone and nextcloud";
      serviceConfig = {
        User = "leo";
        Environment = "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus";
        Restart = "on-failure";
        RestartSec = 30;
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c '/home/leo/.config/bin/home-bk'";
      };
    };
  };
}
