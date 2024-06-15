{
  config,
  pkgs,
  outputs,
  ...
}:
# let
# firacode = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
# in
{
  imports = [outputs.homeManagerModules.firefox];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ben";
  home.homeDirectory = "/home/ben";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    gh
    alejandra
    helix
    nil
    neofetch
    kitty
    keepassxc
    bacon
    obsidian
    keymapp
    libusb
    plasma-browser-integration
    discord
    broot

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
    ".config/onedrive/sync_list".text = ''
      Vault/Database.kdbx
      obsidian
    '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ben/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "ben3dninja";
    userEmail = "benjamin.lagosanto@gmail.com";
  };
  programs.helix = {
    enable = true;
    defaultEditor = true;
    languages = {
      language-server.rust-analyzer.config.check.command = "clippy";
      language = [
        {
          name = "nix";
          formatter.command = "alejandra";
          auto-format = true;
        }
      ];
    };
    settings = {
      editor = {
        line-number = "relative";
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
        };
      };
      keys.normal = {
        space.w = ":w";
        space.q = ":q";
      };
    };
  };
  programs.kitty.enable = true;
  programs.broot = {
    enable = true;
    enableBashIntegration = true;
  };

  fonts.fontconfig.enable = true;

  stylix = {
    autoEnable = true;
    targets.kitty.enable = true;
    targets.gtk.enable = false;
    fonts = {
      monospace = {
        # package = firacode;
        # name = "FiraCode Nerd Font Mono Ret";
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
    };
    opacity = {
      terminal = 0.85;
      desktop = 0.85;
    };
  };
  # gtk.enable = false;
}
