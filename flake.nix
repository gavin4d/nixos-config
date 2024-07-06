{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
        
    ags.url = "github:Aylur/ags";
    waveforms.url = "github:liff/waveforms-flake";
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { home-manager, self, nixpkgs, waveforms, catppuccin, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [ 
          ./configuration.nix 
          home-manager.nixosModule
	  waveforms.nixosModule
	  ({ users.users.gavin4d.extraGroups = [ "plugdev" ]; })
        ];
      };

      homeConfigurations.gavin4d = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };

        # pass inputs as specialArgs
        extraSpecialArgs = { inherit inputs; };

        # import your home.nix
        modules = [ 
	  ./modules/home-manager/home.nix 
	  #catppuccin.homeManagerModules.catppuccin
	];
      };

    };
}
