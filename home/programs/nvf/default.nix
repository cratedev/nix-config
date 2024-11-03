{ inputs, ... }:
{
  # Import all your configuration modules here
  imports = [ 
	./configuration.nix
	inputs.nvf.homeManagerModules.default
  ];
}
