{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "bearer";
  version = "1.8.1";

  src = fetchFromGitHub {
    owner = "bearer";
    repo = "bearer";
    rev = "refs/tags/v${version}";
    hash = "sha256-5Vd6knHm9r2VicHuvPKE7jzRGcNog8THNwDQmW2MJ5Q=";
  };

  vendorHash = "sha256-FRB01Tfz87MZp4V0HPeiEgYV8KEPcbzkeUM0uIBh6DU=";

  subPackages = [
    "cmd/bearer"
  ];

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/bearer/bearer/cmd/bearer/build.Version=${version}"
  ];

  meta = with lib; {
    description = "Code security scanning tool (SAST) to discover, filter and prioritize security and privacy risks";
    homepage = "https://github.com/bearer/bearer";
    changelog = "https://github.com/Bearer/bearer/releases/tag/v${version}";
    license = with licenses; [ elastic ];
    maintainers = with maintainers; [ fab ];
  };
}
