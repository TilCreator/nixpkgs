{ lib, stdenv, fetchFromGitHub }:

let
  pname = "rockchipBinaries";
  version = "2023-07-26";
in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "rockchip-linux";
    repo = "rkbin";
    rev = "b4558da0860ca48bf1a571dd33ccba580b9abe23";
    hash = "sha256-KUZQaQ+IZ0OynawlYGW99QGAOmOrGt2CZidI3NTxFw8=";
  };

  dontBuild = true;
  dontPatchELF = true;
  dontStrip = true;
  noAuditTmpdir = true;
  dontPatchShebangs = true;

  installPhase = ''
    # Remove version from files to not break builds using this dependency on every other update
    for model in bin/*; do
      for file in $model/*; do
        file_no_version="$(echo "$file" | sed -re 's/_v[0-9]+\.[0-9]+//g')"
        if [[ "$file" -ne "$file_no_version" ]]; then
          mv "$file" "$file_no_version"
        fi
      done
    done

    mkdir $out
    cp -r bin/* $out
  '';

  meta = with lib; {
    homepage = "https://github.com/rockchip-linux/rkbin";
    description = "Rockchip Firmware and Tool Binarys";
    license = [ licenses.unfreeRedistributable ];
    maintainers = with maintainers; [ tilcreator ];
  };
}
