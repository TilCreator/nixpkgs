{ lib
, stdenv
, fetchFromGitHub
, portaudio
, speexdsp
, boost
, asio
}:

stdenv.mkDerivation rec {
  pname = "sndlink";
  version = "117a3b21c92fb70e9e5511f49c0bbb4978efdde5";

  src = fetchFromGitHub {
    owner = "koraa";
    repo = pname;
    rev = version;
    sha256 = "sha256-dvQvZ8wSwHZoowliGZ7FM1PCIPeMWD8VD++N1ObZIk0=";
  };

  patches = [
    ./use_system_libaries.patch
  ];

  buildInputs = [ portaudio speexdsp boost asio ];

  meta = with lib; {
    description = "Realtime audio streaming";
    homepage = "https://github.com/koraa/sndlink";
    license = licenses.mit;
    maintainers = with maintainers; [ tilcreator ];
  };
}
