{ inputs, ... }:
{
  # Import all your configuration modules here
  imports = [ 
	inputs.nvf.homeManagerModules.default
  ];
}
