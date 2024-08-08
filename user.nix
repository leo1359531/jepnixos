{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.leo = {
    isNormalUser = true;
    description = "leo";
    extraGroups = ["networkmanager" "wheel" "video" "libvirtd" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };
}
