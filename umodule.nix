{ extraSpecialArgs, ...}:
{
  home-manager = {
    inherit extraSpecialArgs;
    useGlobalPkgs = true;

    users.mon = import ./guser.nix;
  };
}
