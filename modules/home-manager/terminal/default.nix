{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./nvim
    ./fish
    ./lf
  ];
}
