{ mkDerivation, lib, fetchFromGitHub, fetchpatch, fetchgit, pkg-config, cmake, glib, boost, libsigrok
, libsigrokdecode, libserialport, libzip, udev, libusb1, libftdi1, glibmm
, hidapi, bluez, util-linux, libselinux, pcre, python3, qtbase, qtsvg, qttools, libsForQt5
, libsepol
, asciidoctor
}:

mkDerivation rec {
  pname = "smuview";
  version = "master";

  src = fetchFromGitHub {
    owner = "knarfS";
    repo = "smuview";
    #rev = "v${version}";
    rev = "54cf16bc0b2c6e3575a8500a5bda34c2194ef209";
    #sha256 = "sha256-5X9Te96Liuh1k4Hxp86R0DMlSvRKrdmKbc6K1x/z8og=";
    sha256 = "sha256-hFtr3tFt7g3btDvVxNpQFftGn7SdekbOWfMvVFbtGZM=";
  };

  nativeBuildInputs = [ cmake pkg-config ];

  buildInputs = [
    (libsigrok.overrideAttrs (old: let
      rev = "0db1b189bee3ffe5c6ea39d7ca2e62715856b538";
    in {
      version = rev;
      src = fetchgit {
        url = "git://sigrok.org/libsigrok";
        rev = rev;
        sha256 = "sha256-UDUq1s+oUiNd7322LAEKnfdpdDxsRl2A+KhZ/ZCA9lY=";
      };
    }))
    glib boost libsigrokdecode libserialport libzip udev libusb1 libftdi1 glibmm
    hidapi bluez util-linux libselinux pcre python3 libsepol
    qtbase qtsvg qttools libsForQt5.qwt
    asciidoctor
  ];

  meta = with lib; {
    description = "SmuView is a GUI for sigrok that supports power supplies, electronic loads and all sorts of measurement devices like multimeters, LCR meters and so on.";
    homepage = "https://github.com/knarfS/smuview";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ tilcreator ];
    platforms = platforms.linux;
  };
}
