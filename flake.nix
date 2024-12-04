{
  description = "My flakes configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
  };

  outputs = { self, nixpkgs, home-manager }@inputs:
	let specialArgs = {
		inherit inputs;
	};
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        ./laptop_configuration.nix
           {
          home-manager = {
            useUserPackages = true;
            users.mike = import ./home.nix;
            extraSpecialArgs = specialArgs;
          };
	  }
	  ];
        };
      };
    };
}
