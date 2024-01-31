{ lib, stdenvNoCC, fetchzip, makeBinaryWrapper, jdk17_headless, gawk, statePath ? "/var/lib/youtrack" }:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "youtrack";
  version = "2023.3.23390";

  src = fetchzip {
    url = "https://download.jetbrains.com/charisma/youtrack-${finalAttrs.version}.zip";
    hash = "sha256-p3ZjClVku7EjQSd9wwx0iJ+5DqooaKragdNzj0f8OO8=";
  };

  nativeBuildInputs = [ makeBinaryWrapper ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r * $out
    makeWrapper $out/bin/youtrack.sh $out/bin/youtrack \
      --prefix PATH : "${lib.makeBinPath [ gawk ]}" \
      --set JRE_HOME ${jdk17_headless}
    rm -rf $out/internal/java
    mv $out/conf $out/conf.orig
    ln -s ${statePath}/backups $out/backups
    ln -s ${statePath}/conf $out/conf
    ln -s ${statePath}/data $out/data
    ln -s ${statePath}/logs $out/logs
    ln -s ${statePath}/temp $out/temp
    runHook postInstall
  '';

  meta = {
    description = "Issue tracking and project management tool for developers";
    maintainers = lib.teams.serokell.members ++ [ lib.maintainers.leona ];
    sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
    # https://www.jetbrains.com/youtrack/buy/license.html
    license = lib.licenses.unfree;
  };
})
