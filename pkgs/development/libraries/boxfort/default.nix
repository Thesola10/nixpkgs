{ stdenv, coreutils, fetchFromGitHub, cmake, meson, ninja, pkg-config, python3, git }:

stdenv.mkDerivation rec {
  name = "boxfort";
  version = "38fe630";
  
  src = fetchFromGitHub 
    { owner = "Snaipe";
      repo  = "BoxFort";
      rev   = "38fe63046fbabcae34ebc2ee9867d990ac28c4c5";
      sha256 = "03zy982d1frpk9fr4hbp1ql1ah06s0v6dy7a56d1zl3jjjljhrhn";
    };

  buildInputs =
    [ meson
      ninja
      coreutils
      cmake
      pkg-config
      python3
      git
    ];

  preConfigure = ''
    mkdir -p /usr/bin  
    ln -s ${coreutils}/bin/env /usr/bin/env
  '';

  meta = with stdenv.lib;
    { description = "Convenient & cross-platform sandboxing C library";
      homepage    = "https://github.com/Snaipe/BoxFort";
      license     = licenses.mit;
      platforms   = platforms.all;
      maintainer  = with maintainers; [ thesola10 ];
    };
}
