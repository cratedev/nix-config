let
  matt = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIItETI5nQ1tNxHQ7S7dpDodTU1aT6cPe66+jeS3el9Ac";
  users = [ matt ];

  crate-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN3rQZ7xy+WEj610JN65q/NkYEFyntuJQWjTEqgSesXH";
  crate-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKzxQgondgEYcLpcPdJLrTdNgZ2gznOHCAxMdaceTUT1";
  systems = [ crate-laptop crate-desktop ];
in
{
  "secret1.age".publicKeys = [ matt crate-laptop ];
  "secret2.age".publicKeys = users ++ systems;
}