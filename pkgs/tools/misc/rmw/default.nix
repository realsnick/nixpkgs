{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, ncurses
}:

stdenv.mkDerivation rec {
  pname = "rmw";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "theimpossibleastronaut";
    repo = "rmw";
    rev = "v${version}";
    hash = "sha256-KOYj63j/vCG7I63bgep03HzufOj/p/EHaY8lyRMHCkY=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    pkg-config
    meson
    ninja
  ];

  buildInputs = [
    ncurses
  ];

  meta = with lib; {
    description = "Trashcan/ recycle bin utility for the command line";
    homepage = "https://github.com/theimpossibleastronaut/rmw";
    changelog = "https://github.com/theimpossibleastronaut/rmw/blob/${src.rev}/ChangeLog";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ dit7ya ];
  };
}
