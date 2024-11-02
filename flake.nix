{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        #nixpkgs-stable.follows = "nixpkgs-stable";
      };
    };
        
    ags.url = "github:Aylur/ags";
    waveforms.url = "github:liff/waveforms-flake";
    catppuccin.url = "github:catppuccin/nix";
    CCStudio.url = "path:/etc/nixos/modules/home-manager/programs/CCStudio";
  };

  outputs = { home-manager, self, nixpkgs, waveforms, catppuccin, CCStudio, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        # module.args = { inherit CCStudio;};
        modules = [ 
          ./configuration.nix 
          home-manager.nixosModule
      	  waveforms.nixosModule
          # CCStudio
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
