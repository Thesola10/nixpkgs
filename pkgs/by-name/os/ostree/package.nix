{ stdenv
, lib
, fetchurl
, pkg-config
, gtk-doc
, gobject-introspection
, curl
, glib
, xz
, libsoup
, glib-networking
, wrapGAppsNoGuiHook
, gpgme
, which
, makeWrapper
, autoconf
, automake
, libtool
, macfuse-stubs
, libsodium
, libarchive
, bzip2
, bison
, libxslt
, docbook-xsl-nons
, docbook_xml_dtd_42
, python3
, e2fsprogs
, darwin
}:

let
  inherit (darwin) Libsystem;
  testPython = python3.withPackages (p: with p; [
    pyyaml
  ]);
in stdenv.mkDerivation rec {
  pname = "ostree";
  version = "2024.8";

  outputs = [ "out" "dev" "man" "installedTests" ];

  src = fetchurl {
    url = "https://github.com/ostreedev/ostree/releases/download/v${version}/libostree-${version}.tar.xz";
    sha256 = "sha256-4hNuEWZp8RT/c0nxLimfY8C+znM0UWSUFKjc2FuGPD8=";
  };


  nativeBuildInputs = [
    autoconf
    automake
    libtool
    pkg-config
    gtk-doc
    gobject-introspection
    which
    makeWrapper
    bison
    libxslt
    docbook-xsl-nons
    docbook_xml_dtd_42
    wrapGAppsNoGuiHook
  ];

  buildInputs = [
    curl
    glib
    libsoup
    glib-networking
    gpgme
    macfuse-stubs
    libsodium
    libarchive
    bzip2
    xz
    Libsystem
    e2fsprogs
  ];

  enableParallelBuilding = true;

  configureFlags = [
    "--with-curl"
    "--without-selinux"
    "--without-libsystemd"
    "--with-ed25519-libsodium"
  ];

  makeFlags = [
    # Setting this flag was required as workaround for a clang bug, but seems not relevant anymore.
    # https://github.com/ostreedev/ostree/commit/fd8795f3874d623db7a82bec56904648fe2c1eb7
    # See also Makefile-libostree.am
    "INTROSPECTION_SCANNER_ENV="
  ];

  preConfigure = ''
    env NOCONFIGURE=1 ./autogen.sh
  '';

  meta = with lib; {
    description = "Git for operating system binaries";
    homepage = "https://ostreedev.github.io/ostree/";
    license = licenses.lgpl2Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ copumpkin ];
  };
}
