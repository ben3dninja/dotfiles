{
  config,
  pkgs,
  outputs,
  lib,
  ...
}:
# let
# firacode = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
# in
# let
#   modifyHelixTheme = pkgs.writeShellScriptBin "modify-helix-theme" ''
#     #!/bin/sh
#     ${pkgs.gnused}/bin/sed -i 's/"ui.virtual.inlay-hint" = { fg = "base01" }/"ui.virtual.inlay-hint" = { fg = "base03" }/' $HOME/.config/helix/themes/stylix.toml
#   '';
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
      theme = "stylix";
    };
  };
  # home.activation = {
  #   fixHelixColors = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #     ${modifyHelixTheme}/bin/modify-helix-theme
  #   '';
  # };
  home.file.".config/helix/themes/stylix.toml".text = ''
    "attributes" = "base09"
    "comment" = { fg = "base03", modifiers = ["italic"] }
    "constant" = "base09"
    "constant.character.escape" = "base0C"
    "constant.numeric" = "base09"
    "constructor" = "base0D"
    "debug" = "base03"
    "diagnostic" = { modifiers = ["underlined"] }
    "diff.delta" = "base09"
    "diff.minus" = "base08"
    "diff.plus" = "base0B"
    "error" = "base08"
    "function" = "base0D"
    "hint" = "base03"
    "info" = "base0D"
    "keyword" = "base0E"
    "label" = "base0E"
    "namespace" = "base0E"
    "operator" = "base05"
    "special" = "base0D"
    "string"  = "base0B"
    "type" = "base0A"
    "variable" = "base08"
    "variable.other.member" = "base0B"
    "warning" = "base09"

    "markup.bold" = { fg = "base0A", modifiers = ["bold"] }
    "markup.heading" = "base0D"
    "markup.italic" = { fg = "base0E", modifiers = ["italic"] }
    "markup.link.text" = "base08"
    "markup.link.url" = { fg = "base09", modifiers = ["underlined"] }
    "markup.list" = "base08"
    "markup.quote" = "base0C"
    "markup.raw" = "base0B"
    "markup.strikethrough" = { modifiers = ["crossed_out"] }

    "diagnostic.hint" = { underline = { style = "curl" } }
    "diagnostic.info" = { underline = { style = "curl" } }
    "diagnostic.warning" = { underline = { style = "curl" } }
    "diagnostic.error" = { underline = { style = "curl" } }

    "ui.background" = { }
    "ui.bufferline.active" = { fg = "base00", bg = "base03", modifiers = ["bold"] }
    "ui.bufferline" = { fg = "base04" }
    "ui.cursor" = { fg = "base0A", modifiers = ["reversed"] }
    "ui.cursor.insert" = { fg = "base0A", modifiers = ["revsered"] }
    "ui.cursorline.primary" = { fg = "base05", bg = "base01" }
    "ui.cursor.match" = { fg = "base0A", modifiers = ["reversed"] }
    "ui.cursor.select" = { fg = "base0A", modifiers = ["reversed"] }
    "ui.gutter" = { }
    "ui.help" = { fg = "base06", bg = "base01" }
    "ui.linenr" = { fg = "base03" }
    "ui.linenr.selected" = { fg = "base04", bg = "base01", modifiers = ["bold"] }
    "ui.menu" = { fg = "base05", bg = "base01" }
    "ui.menu.scroll" = { fg = "base03", bg = "base01" }
    "ui.menu.selected" = { fg = "base01", bg = "base04" }
    "ui.popup" = { bg = "base01" }
    "ui.selection" = { bg = "base02" }
    "ui.selection.primary" = { bg = "base02" }
    "ui.statusline" = { fg = "base04", bg = "base01" }
    "ui.statusline.inactive" = { bg = "base01", fg = "base03" }
    "ui.statusline.insert" = { fg = "base00", bg = "base0B" }
    "ui.statusline.normal" = { fg = "base00", bg = "base03" }
    "ui.statusline.select" = { fg = "base00", bg = "base0F" }
    "ui.text" = "base05"
    "ui.text.focus" = "base05"
    "ui.virtual.indent-guide" = { fg = "base03" }
    "ui.virtual.inlay-hint" = { fg = "base03" }
    "ui.virtual.ruler" = { bg = "base01" }
    "ui.window" = { bg = "base01" }
    "ui.cursor.primary" = { fg = "base09", modifiers = ["reversed"] }

    [palette]
    base00 = "#${config.lib.stylix.colors.base00}" # Default Background
    base01 = "#${config.lib.stylix.colors.base01}" # Lighter Background (Used for status bars, line number and folding marks)
    base02 = "#${config.lib.stylix.colors.base02}" # Selection Background
    base03 = "#${config.lib.stylix.colors.base03}" # Comments, Invisibles, Line Highlighting
    base04 = "#${config.lib.stylix.colors.base04}" # Dark Foreground (Used for status bars)
    base05 = "#${config.lib.stylix.colors.base05}" # Default Foreground, Caret, Delimiters, Operators
    base06 = "#${config.lib.stylix.colors.base06}" # Light Foreground (Not often used)
    base07 = "#${config.lib.stylix.colors.base07}" # Light Background (Not often used)
    base08 = "#${config.lib.stylix.colors.base08}" # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
    base09 = "#${config.lib.stylix.colors.base09}" # Integers, Boolean, Constants, XML Attributes, Markup Link Url
    base0A = "#${config.lib.stylix.colors.base0A}" # Classes, Markup Bold, Search Text Background
    base0B = "#${config.lib.stylix.colors.base0B}" # Strings, Inherited Class, Markup Code, Diff Inserted
    base0C = "#${config.lib.stylix.colors.base0C}" # Support, Regular Expressions, Escape Characters, Markup Quotes
    base0D = "#${config.lib.stylix.colors.base0D}" # Functions, Methods, Attribute IDs, Headings
    base0E = "#${config.lib.stylix.colors.base0E}" # Keywords, Storage, Selector, Markup Italic, Diff Changed
    base0F = "#${config.lib.stylix.colors.base0F}" # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
  '';

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
    targets.helix.enable = false;
    fonts = {
      monospace = {
        # package = firacode;
        # name = "FiraCode Nerd Font Mono Ret";
        package = pkgs.jetbrains-mono;
        name = "JetBrains Mono";
      };
    };
    opacity = {
      terminal = 0.9;
      desktop = 0.9;
    };
  };
  # gtk.enable = false;
}
