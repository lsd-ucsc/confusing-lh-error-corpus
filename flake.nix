{
  description = "confusing LH error corpus";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;

    flake-utils.url = github:numtide/flake-utils;

    liquidhaskell.url = github:plredmond/liquidhaskell/nix-flake;
    liquidhaskell.inputs.nixpkgs.follows = "nixpkgs";
    liquidhaskell.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, liquidhaskell }:
    let
      composeOverlays = funs: builtins.foldl' nixpkgs.lib.composeExtensions (self: super: { }) funs;
      haskellPackagesOverlay = compiler: final: prev: overrides: {
        haskell = prev.haskell // {
          packages = prev.haskell.packages // {
            ${compiler} = prev.haskell.packages.${compiler}.extend overrides;
          };
        };
      };
      ghc = "ghc8102";
      mkOutputs = system: {

        overlays = {
          addCLHEC = final: prev: haskellPackagesOverlay ghc final prev (self: super:
            with prev.haskell.lib; {
              confusing-lh-error-corpus =
                let
                  src = prev.nix-gitignore.gitignoreSource [ "*.nix" "result" "build-env" "*.cabal" "deploy/" ] ./.;
                  drv = super.callCabal2nix "confusing-lh-error-corpus" src { };
                in
                overrideCabal drv (old: {
                  enableLibraryProfiling = false;
                  buildTools = old.buildTools or [ ] ++ [ final.z3 ];
                });
            });
        };

        overlay = composeOverlays [
          liquidhaskell.overlay.${system}
          self.overlays.${system}.addCLHEC
        ];

        packages =
          let pkgs = import nixpkgs { inherit system; overlays = [ self.overlay.${system} ]; };
          in { confusing-lh-error-corpus = pkgs.haskell.packages.${ghc}.confusing-lh-error-corpus; };

        defaultPackage = self.packages.${system}.confusing-lh-error-corpus;

        devShell = self.defaultPackage.${system}.env;
      };
    in
    flake-utils.lib.eachDefaultSystem mkOutputs;

}
