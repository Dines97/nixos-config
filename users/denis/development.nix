{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      # Kubernetes
      kubectl
      kubernetes-helm
      kube3d
      kind
      k9s
      kubebuilder
      cue
      skaffold
      minikube
      docker-machine-kvm2 # Minikube driver
      pv-migrate
      jq
      yq-go
      talosctl
      argo
      argocd
      skopeo

      # DevOps
      docker-compose
      terraform
      infracost
      (ansible.override {windowsSupport = true;})
      # vagrant

      # Database
      postgresql

      # Cloud
      (google-cloud-sdk.withExtraComponents (with google-cloud-sdk.components; [
        # gke-gcloud-auth-plugin
        anthos-auth
      ]))
      (azure-cli.withExtensions (with azure-cli.extensions; [
        azure-devops
      ]))

      # Python
      # conda

      # Dotnet
      dotnet-sdk_8

      # Haskell
      # cabal-install
      # ghc
      # haskell-language-server
      # haskellPackages.haskell-language-server

      # JavaScript
      # bun
      # nodejs_20
      # typescript # For volar in neovim to use

      # Flutter
      # flutter

      # Java
      (openjdk17.override {enableJavaFX = true;})
      # openjdk11
      gradle
    ];
  };
}
