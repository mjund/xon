{ pkgs, ... }:
{
 programs = {
    chromium = {
      enable = true;
      package = pkgs.chromium;
      extensions = [
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
        { id = "ijpiffheldgmdkbaohoilabdnmeinand"; }
        { id = "ppbibelpcjmhbdihakflkdcoccbgbkpo"; }
        { id = "idnnbdplmphpflfnlkomgpfbpcgelopg"; }
      ];
    };
  };
}
