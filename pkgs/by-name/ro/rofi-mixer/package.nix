{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  python3,
  pulseaudio,
}:

stdenv.mkDerivation {
  pname = "rofi-mixer";
  version = "unstable-2022-10-12";

  src = fetchFromGitHub {
    owner = "joshpetit";
    repo = "rofi-mixer";
    rev = "9944bf9dbea915f0ecaf3163fff94f5f6d53a88c";
    hash = "sha256-hBjgGLDK10AY7oo2NP3gYRbNxjR2LFsZD5qCr7PgdXI=";
  };

  sourceRoot = "source/src";

  buildInputs = [ python3 ];
  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    install -Dm755 rofi-mixer.py $out/bin/rofi-mixer.py
    wrapProgram $out/bin/rofi-mixer.py --prefix PATH : ${lib.makeBinPath [ pulseaudio ]}

    install -Dm755 rofi-mixer $out/bin/rofi-mixer
  '';

  meta = {
    description = "A sound device mixer made with rofi";
    homepage = "https://github.com/joshpetit/rofi-mixer";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ElliottSullingeFarrall ];
    mainProgram = "rofi-mixer";
    platforms = lib.platforms.all;
  };
}
