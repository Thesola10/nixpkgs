{ lib, buildPythonPackage, fetchPypi
, setuptools-scm
, more-itertools, backports_functools_lru_cache }:

buildPythonPackage rec {
  pname = "jaraco.functools";
  version = "3.5.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-0K3PkXEKCFPv6fI6ePrVhr9n31cvDW2OD6NtKJrhwdk=";
  };

  nativeBuildInputs = [ setuptools-scm ];

  propagatedBuildInputs = [ more-itertools backports_functools_lru_cache ];

  doCheck = false;

  pythonNamespaces = [ "jaraco" ];

  meta = with lib; {
    description = "Additional functools in the spirit of stdlib's functools";
    homepage = "https://github.com/jaraco/jaraco.functools";
    license = licenses.mit;
  };
}
