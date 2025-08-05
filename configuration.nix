{
  config, lib, pkgs,... }:
let
in
{
  imports = [
    ./disk-config.nix
  ];

  boot.loader.grub = {
    efiSupport = false;
  };

  networking.hostName = "nixos-anywhere";
  networking.useDHCP = false;
  networking.bridges = {
    "br0" = {
      interfaces = [ "enp1s0" ];
    };
  };

  networking.interfaces.br0.ipv4.addresses = [ {
    address = "192.168.122.30";
    prefixLength = 24;
    dns = [ "192.168.122.1"];
  } ];

  networking.defaultGateway = "192.168.122.1";

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
    useXkbConfig = false;
  };

  environment.systemPackages = with pkgs; [
    wget
    vim
    htop
    bridge-utils
    git
    wireguard-tools
    iptables
    dig
    xfsprogs
  ];

  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMy0zk45FEZIRfYolYTXmFaTmNB13QoQJBwRBc/iEyMZ emil@asn"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
