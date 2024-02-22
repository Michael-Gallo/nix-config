{
  description = "My flakes configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
  };

  outputs = { self, nixpkgs, home-manager }@inputs:
	let specialArgs = {
		inherit inputs;
	};
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
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
