{
  inputs.nixpkgs.url = github:nixos/nixpkgs;
  inputs.flake-compat = {
    url = github:edolstra/flake-compat;
    flake = false;
  };

  outputs = { nixpkgs, ... }: with builtins; let
    system = "x86_64-linux";

    pkgs = import nixpkgs { inherit system; };
    inherit (pkgs) lib;

    envVars = map (i: {
      name  = "MY_ENV_THIS_VAR_IS_KIND_OF_LONG_${toString i}";
      value =  "this value is relatively long test test test test test test test test test abcdef fjasdjfjs" + toString i;
    }) (lib.range 0 1000);

  in {
    devShell.${system} = pkgs.mkShell ({
      name = "direnv-test";
    } // lib.listToAttrs envVars);
  };
}
