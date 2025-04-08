{
  description = "Infrastructure as Code - GitOps";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      # Helper functions for creating package sets.
      withSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      withPkgs =
        callback:
        withSystem (
          system:
          callback (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true; # Required by Terraform CLI
            }
          )
        );
    in
    {
      # Development Environments
      devShells = withPkgs (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            terraform # Infrastructure as Code CLI
            # opentofu # IaC CLI TODO! Verify terraform compatability
            hcloud # Hetzner Cloud CLI
            minio-client # S3/MinIO CLI (Terraform state backend)
            k3d # Local Kubernetes cluster CLI
            fluxcd # GitOps Operator CLI
            kubectl # Kubernetes CLI
            talosctl # Talos CLI
            k9s # Kubernetes TUI
            docker # Container CLI
            packer # Tool for creating machine images from common source
          ];
        };
      });

      formatter = withPkgs (pkgs: pkgs.nixfmt-rfc-style);
    };
}
