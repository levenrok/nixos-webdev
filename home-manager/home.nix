# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs
, lib
, config
, pkgs
, ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configuration for nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "levenrok";
    homeDirectory = "/home/levenrok";
  };

  # Gnome Shell
  programs.gnome-shell = {
    enable = true;
    extensions = [
      { package = pkgs.gnomeExtensions.dash-to-dock; }
    ];
  };

  # NodeJS, PHP 8.4 and Ruby
  home.packages = with pkgs; [
    nodejs
    php84Packages.composer
    (php84.withExtensions ({ enabled, all }: enabled ++ [ all.opcache ]))
    ruby
  ];

  # starship.rs
  programs.starship = {
    enable = true;
  };

  # Ghostty
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "light:tokyonight-day,dark:tokyonight";

      font-size = 14;
      font-family = "JetBrainsMono Nerd Font Mono";
    };
  };

  # Code
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "levenrok";
    userEmail = "levenrok@proton.me";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
