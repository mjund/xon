{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.my;
let cfg = config.modules.desktop.browsers.chromium;
in {
  options.modules.desktop.browsers.chromium = with types; {
    enable = mkBoolOpt true;
  };

  config = mkIf cfg.enable (mkMerge [
    {
      nixpkgs.overlays = [ inputs.nur.overlay ];
      user.packages = with pkgs; [
        ungoogled-chromium
      ];

      programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;
                extensions =
        let
          createChromiumExtensionFor = browserVersion: { id, sha256, version }:
            {
              inherit id;
              crxPath = builtins.fetchurl {
                url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${browserVersion}&x=id%3D${id}%26installsource%3Dondemand%26uc";
                name = "${id}.crx";
                inherit sha256;
              };
              inherit version;
            };
          createChromiumExtension = createChromiumExtensionFor (lib.versions.major pkgs.ungoogled-chromium.version);
        in
        [
          (createChromiumExtension {
            # ublock origin
            id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
            sha256 = "sha256:026l3wq4x7rg9f0dz4xiig25x8b7h0syil1d09hbpfzv0yg5bm4m";
            version = "1.37.2";
          })
          (createChromiumExtension {
            # dark reader
            id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
            sha256 = "sha256:1xw996dmkzsx2pmilb3ivyfnjckm2g1f2sx10yd4nllqbz5076mm";
            version = "4.9.34";
          })
        ];
        
      };
    }
  ]);
}
