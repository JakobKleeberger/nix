{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars

      pkgs.jetbrains-mono
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.symbols-only

      # Rust
      pkgs.rust-analyzer
      pkgs.rustfmt
      pkgs.cargo
      pkgs.gcc_multi
      # Python
      pkgs.pyright
      pkgs.ruff
      # Nix
      pkgs.nil
      pkgs.nixd
      pkgs.nixdoc
      pkgs.nixfmt
      # Latex
      pkgs.gnuplot
      # Java
      pkgs.jdt-language-server
    ];
  };
}
