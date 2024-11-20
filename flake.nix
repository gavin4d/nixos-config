{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # nixpkgs-stable.follows = "nixpkgs";
      };
    };
        
    ags.url = "github:Aylur/ags";
    waveforms.url = "github:liff/waveforms-flake";
    catppuccin.url = "github:catppuccin/nix";
    CCStudio.url = "path:/etc/nixos/modules/home-manager/programs/CCStudio";
  };

  outputs = { home-manager, self, nixpkgs, nixpkgs-stable, waveforms, catppuccin, CCStudio, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = import nixpkgs-stable {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };
        # legacyPackages.${system};
      };
      allowed-unfree-packages = [
        "steam"
      ];
    in
    {
    
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit allowed-unfree-packages;
        };
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
        extraSpecialArgs = {
          inherit inputs;
          inherit pkgs-stable;
          inherit allowed-unfree-packages;
        };

        # import your home.nix
        modules = [ 
      	  ./modules/home-manager/home.nix 
      	  #catppuccin.homeManagerModules.catppuccin
      	];
      };
    };
}
