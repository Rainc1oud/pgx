
{ pkgs ? import <nixpkgs> {}
, unstable ? import <unstable> {}
}:

pkgs.mkShell {
  buildInputs = with pkgs; [
    gnumake mono nodejs-16_x
    sqlite # for duplicati/mono
    lsd # for convenience
  ] ++ (with unstable; [
    go_1_19 gopls
  ]);
  shellHook = ''
    export LD_LIBRARY_PATH=${pkgs.sqlite.out}/lib
    export SSH_AUTH_SOCK=/run/user/$UID/keyring/ssh
    export GIT_SSL_CAINFO=/etc/ssl/certs/ca-certificates.crt
    export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
  '';
}