{ extraSpecialArgs, ...}:
{
  home-manager = {
    inherit extraSpecialArgs;
    useGlobalPkgs = true;

    users.mon = import ./tty/usr/tuser.nix;
  };
}
