{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mike";
  home.homeDirectory = "/home/mike";

  dconf = {
    enable = true;
    settings = {
      "org/x/apps/portal/color-scheme" = {
        color-scheme = "prefer-dark";
      };
      # CINNAMON
      "org/cinnamon" = {
        panels-enabled = ["1:0:top"];
        panels-height = ["1:30"];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        clock-format = "12h";
      };
      "org/cinnamon/desktop/interface" = {
        clock-use-24h=false;
        gtk-theme = "Mint-Y-Dark-Teal";
        icon-theme = "Mint-Y-Teal";
        cursor-theme = "Bibata-Modern-Classic";
      };
      "org/cinnamon/desktop/sound" = {
      	event-sounds=false;
      };
      "org/cinnamon/desktop/keybindings/wm" ={
        maximize = ["<Super>Up" "<Super>f"];
        switch-to-workspace-down = [];
        switch-to-workspace-up = ["<Alt>F1"];

      };
      "org/cinnamon/desktop/keybindings/media-keys" ={
      	www =  ["<Super>b"];
        terminal = ["<Primary><Alt>t" "<Super>Return"];
      };
      "org/cinnamon/theme" = {
      	name = "Mint-L-Dark-Teal";
      };
      "org/cinnamon/gestures" = {
        enabled = true;
      };
      "org/cinnamon/muffin" = {
        tile-maximize = true;
      };
      "org/cinnamon/settings-daemon/plugins/power" = {
        lid-close-ac-action = "suspend";
      };
      "org/gnome/desktop/a11y/applications" = {
        screen-keyboard-enabled = false; 
      };

    };
  };
  # This value determines the Home Manager release that your configuration ijs
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    brave
    btop
    direnv # used by VScode
    discord
    go
    libreoffice
    joplin-desktop
    xclip
    firefox
    tldr
    unzip

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mike/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE=1;

  };

  programs.zsh = {
	enable = true;
	autocd = true;
	enableAutosuggestions = true;
	syntaxHighlighting.enable = true;
	envExtra = ''
	bindkey ^k autosuggest-accept
	'';
  };

  programs.neovim = {
  	enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
    set number relativenumber
    '';
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      golang.go
      bbenoist.nix
      ms-python.python
      ms-python.vscode-pylance
    ];
    userSettings = {
      "editor.fontSize" = 14;
      "editor.minimap.enabled" = false;
      "git.autofetch" = true;
      "editor.lineNumbers" = "relative";
      "vim.useSystemClipboard" = true;
      "git.confirmSync" = false;
      "terminal.integrated.allowChords" = false;
      "keyboard.dispatch" = "keyCode";
      "vim.handleKeys" = {
        "<C-p>" = false;
      };
    };
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
