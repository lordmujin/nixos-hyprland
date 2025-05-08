# _   _ _       ___  ____  
#| \ | (_)_  __/ _ \/ ___| 
#|  \| | \ \/ / | | \___ \ 
#| |\  | |>  <| |_| |___) |
#|_| \_|_/_/\_\\___/|____/ 
#
{ config, pkgs, ... }:

{

  # NixOS release
  system.stateVersion = "24.11";

  imports =
    [
	./hardware-configuration.nix
    ];

  # Experimental Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Bootloader
  boot.loader.systemd-boot = {
  	enable = true;
  	consoleMode = "max";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Scheduler
  services.scx.enable = true;
  services.scx.scheduler = "scx_lavd";

  # Nvidia
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
	graphics.enable = true;
	nvidia.modesetting.enable = true;
	nvidia.powerManagement.enable = false;
	nvidia.powerManagement.finegrained = false;
	nvidia.open = true;
	nvidia.nvidiaSettings = true;
	nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  };


  # Network
  networking.hostName = "$HOSTNAME";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.nftables.enable = true;


  # Shell
  programs.fish.enable = true;
  
  # User Account
  users.users.$USER = {
    isNormalUser = true;
    description = "$USERNAME";
    shell = pkgs.fish;
    extraGroups = [ "video" "audio" "storage" "networkmanager" "wheel" ];
  };

  # Timezone
  time.timeZone = "Europe/Lisbon";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Keymap
  services.xserver.xkb = {
    layout = "pt";
    variant = "";
  };
  console.keyMap = "pt-latin1";

  # Pipewire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  # Display Manager

  # ly Display manager
  # services.displayManager.ly.enable = true;

  # tuigreetd	
  services.greetd = {
	enable = true;
	settings = { 
		initial_session = {
      		command = "${pkgs.greetd.tuigreet}/bin/tuigreet --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red";
          	user = "luma";			
		};
		default_session = {
      		command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session";
          	user = "greeter";
		};
	};
  };
  systemd.services.greetd.serviceConfig = {
	Type = "idle";
	StandardInput = "tty";
	StandardOutput = "tty";
	StandardError = "journal";
	TTYReset = true;
	TTYVHangup = true;
	TTYVTDisallocate = true;
  };

  # Cosmic Greeter
  # services.displayManager.cosmic-greeter.enable = true;
  
  # Cosmic Desktop
  # services.desktopManager.cosmic.enable = true;

  # Hyprland
  programs.hyprland.enable = true;
  
  # GVFS
  services.gvfs.enable = true;
  services.tumbler.enable = true;  

  # Environment
  environment = {
    shells = [ pkgs.fish ];
    variables = {
      EDITOR = "micro";
      SYSTEMD_EDITOR = "micro";
      VISUAL = "micro";
    };
  };

  environment.sessionVariables = {
	NIXOS_OZONE_WL = "1";	
  };


  # Allow packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # Fonts
  fonts.packages = with pkgs; [
  	nerd-fonts.symbols-only
  	nerd-fonts.jetbrains-mono
  	nerd-fonts.hack
  ];

  # Applications
  environment.systemPackages = with pkgs; [
  # System
	killall
	libunwind
	appimage-run
  # Terminal
	fishPlugins.tide
	kitty
	ghostty
	micro
	yazi
	fastfetch
	pokeget-rs
	asciiquarium-transparent
	cmatrix
	figlet
	cava
	btop
	eza
	git
	gh
  # Hyprland
  	xdg-desktop-portal-hyprland
	hyprlang
	hyprlock
	hyprshot
	hyprcursor
	pyprland
	swww
	waybar
	wofi
	wlogout
	swaynotificationcenter
	polkit_gnome
	playerctl
  # Apps
	isoimagewriter
	gvfs
	nemo
	nemo-with-extensions
	mate.engrampa
	loupe
	p7zip
	p7zip-rar
	nwg-look
	geany
	gimp3
	lagrange
	obsidian
  # Games
	lutris
	cartridges
	prismlauncher
	protontricks
	protonplus
  # Media
	librewolf
	freetube
  # Audio
	pavucontrol
	audacious
	lollypop	
  ];
  
  programs.steam ={
	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
	localNetworkGameTransfers.openFirewall = true;
  };

}
