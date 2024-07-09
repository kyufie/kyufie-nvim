{
  description = "Kyufie's neovim config";

  # Nixpkgs / NixOS version to use.
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }:
    let
      # to work with older version of flakes
      lastModifiedDate = self.lastModifiedDate or self.lastModified or "19700101";

      # Generate a user-friendly version number.
      version = builtins.substring 0 8 lastModifiedDate;

      # System types to support.
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ self.overlay ]; });

    in

    {

      # A Nixpkgs overlay.
      overlay = final: prev: {

        drv = final.stdenv.mkDerivation {
          name = "kyufie-nvim-cfg-${version}";
          src = ./.;

          installPhase =
            ''
              cp -r . $out
            '';
        };

      };

      packages = forAllSystems (system:
        {
          inherit (nixpkgsFor.${system}) drv;
        });

      defaultPackage = forAllSystems (system: self.packages.${system}.drv);
    };
}
