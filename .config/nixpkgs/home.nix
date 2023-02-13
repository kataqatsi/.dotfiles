{ config, pkgs, lib, ... }:

let
  fromGitHub = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kataqatsi";
  home.homeDirectory = "/Users/kataqatsi";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.zsh = {
      enable = true;
      # enableCompletion = true;
      # enableAutosuggestions = true;
      oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "half-life";
      };
      plugins = [
      #  {
       #   name = "zsh-autosuggestions";
        #  src = pkgs.fetchFromGitHub {
         #   owner = "zsh-users";
          #  repo = "zsh-autosuggestions";
           # rev = "v0.6.3";
            #sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
        #  };
        # }
      # {
      #   name = "zsh-syntax-highlighting";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "zsh-users";
      #     repo = "zsh-syntax-highlighting";
      #     rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
      #     sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
      #   };
      #  }
      ];

      sessionVariables = rec {
        NVIM_TUI_ENABLE_TRUE_COLOR = "1";

        HOME_MANAGER_CONFIG = /Users/kataqatsi/.config/nixpkgs/home.nix;

        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=3";
        DEV_ALLOW_ITERM2_INTEGRATION = "1";

        EDITOR = "vim";
        VISUAL = EDITOR;
        GIT_EDITOR = EDITOR;
      };

      # envExtra
      # profileExtra
      # loginExtra
      # logoutExtra
      # localVariables
   };
   
   programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraConfig = builtins.readFile /Users/kataqatsi/.vimrc;

      plugins = with pkgs.vimPlugins; [
        # Syntax / Language Support ##########################
        vim-nix
        vim-ruby # ruby
        vim-go # go
        # vim-toml           # toml
        # vim-gvpr           # gvpr
        rust-vim # rust
        zig-vim
        vim-pandoc # pandoc (1/2)
        vim-pandoc-syntax # pandoc (2/2)

        (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
        
        # (nvim-treesitter.withPlugins (
        # https://github.com/NixOS/nixpkgs/tree/nixos-unstable/pkgs/development/tools/parsing/tree-sitter/grammars
        # plugins:
        #  with plugins; [
        #    tree-sitter-lua
        #    tree-sitter-vim
        #    tree-sitter-html
        #    yaml
        #    json
        #    markdown
        #    comment
        #    bash
        #    javascript
        #    nix
        #    typescript
        #    c
        #    java
        #    query # for the tree-sitter itself
        #    python
        #    go
        #    hocon
        #    sql
        #   graphql
        #   dockerfile
        #  ]
      # ))


        # yajs.vim           # JS syntax
        # es.next.syntax.vim # ES7 syntax

        # UI #################################################
#        gruvbox # colorscheme
        # vim-gitgutter # status in gutter
        # vim-devicons
        # vim-airline
        rose-pine
        # Editor Features ####################################
        vim-abolish
        vim-surround # cs"'
        vim-repeat # cs"'...
        vim-commentary # gcap
        # vim-ripgrep
        vim-indent-object # >aI
        vim-easy-align # vipga
        vim-eunuch # :Rename foo.rb
        vim-sneak
        supertab

        # vim-endwise        # add end, } after opening block
        # gitv
        # tabnine-vim
        ale # linting
        # vim-toggle-quickfix
        # neosnippet.vim
        # neosnippet-snippets
        # splitjoin.vim
        nerdtree

        # Buffer / Pane / File Management ####################
        fzf-vim # all the things

        # Panes / Larger features ############################
        tagbar # <leader>5
        vim-fugitive # Gblame
      ];
    };

}
