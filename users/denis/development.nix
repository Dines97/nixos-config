{
  pkgs,
  config,
  ...
}: let
  my-python-packages = ps:
    with ps; [
      nextcord
      sqlalchemy
      google
      google-api-core
      google-cloud-texttospeech
      setuptools
      psycopg2

      pandas
      requests
      # other python packages
      fastapi
      uvicorn

      asgiref
      async-timeout
      certifi
      charset-normalizer
      click
      django
      idna
      importlib-metadata
      pysocks
      python-dotenv
      redis
      six
      spotipy
      sqlparse
      typing-extensions
      urllib3
      zipp
    ];
in {
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

      # DevOps
      docker-compose
      terraform
      infracost
      (ansible.override {windowsSupport = true;})
      vagrant

      # Database
      postgresql

      # Cloud
      (pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
        # gke-gcloud-auth-plugin
        anthos-auth
      ]))
      # azure-cli

      # Python
      (pkgs.python3.withPackages my-python-packages)
      conda

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
      flutter

      # Java
      (openjdk17.override {enableJavaFX = true;})
      # openjdk11
      gradle
    ];
  };
}
