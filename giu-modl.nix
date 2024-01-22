{ extraSpecialArgs, ...}:
{
  home-manager = {
    inherit extraSpecialArgs;
    useGlobalPkgs = true;

    users.mon = import ./gui/usr/guser.nix;
  };
}
