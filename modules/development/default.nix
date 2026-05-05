{
  imports = [
    ./packettracer.nix
    ./editor
    ./docker_compose_arion.nix
    ./environment.nix
    ./databases/postgresql.nix
    ./databases/pgadmin.nix
  ];
}
