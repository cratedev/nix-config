{ inputs, ... }:
{
  # Import all your configuration modules here
  imports = [ 
	./bufferline.nix
	inputs.nixvim.homeManagerModules.nixvim
  ];
}
