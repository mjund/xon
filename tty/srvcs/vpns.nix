// omitted the function parameters/headers for brevity
{
    // ...

    environment.systemPackages = with pkgs; [
        //...
        // add the CLI
        tailscale
    ];

    // add the services
    services.tailscale.enable = true;

    // ...
}
