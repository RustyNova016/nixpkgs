{
  lib,
  rustPlatform,
  fetchFromGitHub,
  nix-update-script,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "hotpath";
  version = "0.19.1";

  src = fetchFromGitHub {
    owner = "pawurb";
    repo = "hotpath-rs";
    tag = "v${finalAttrs.version}";
    hash = "sha256-IvwVm9z1RrHCaDgg7b9OS5yeKgkS1C2xCDidBquwdaY=";
  };

  cargoHash = "sha256-54Kc/trzx8EFAjqhWqusK5BTsmIe4q0ziXnQC3vT33w=";

  buildFeatures = [ "tui" ];

  # Tests aren't meant to be run only on the tui feature
  doCheck = false;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    homepage = "https://hotpath.rs/";
    changelog = "https://github.com/pawurb/hotpath-rs/blob/${finalAttrs.src.tag}/CHANGELOG.md";
    description = "Quickly find bottlenecks in Rust - one profiler for CPU, time, memory, and async code.";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      RustyNova
    ];
    mainProgram = "hotpath";
  };
})
