{ lib
, buildPythonPackage
, fetchFromGitHub
, cachetools
, paho-mqtt
, pytz
, requests
, requests_oauthlib
, pythonOlder
}:

buildPythonPackage rec {
  pname = "pysmappee";
  version = "0.2.18";
  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "smappee";
    repo = pname;
    rev = version;
    sha256 = "sha256-DnRtKr8aGZ6rcN/wTpcFNaI+EJm07nObfWyBpLkQF38=";
  };

  propagatedBuildInputs = [
    cachetools
    paho-mqtt
    pytz
    requests
    requests_oauthlib
  ];

  # Project has no tests
  doCheck = false;
  pythonImportsCheck = [ "pysmappee" ];

  meta = with lib; {
    description = "Python Library for the Smappee dev API";
    homepage = "https://github.com/smappee/pysmappee";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
