{ lib
, buildPythonPackage
, fetchPypi
, cmake
, numpy
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "iminuit";
  version = "2.12.2";
  format = "setuptools";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-KRQu04z5hsCGg9yekSpISrxwlipNNtfXG32dhyMWvo4=";
  };

  nativeBuildInputs = [
    cmake
  ];

  propagatedBuildInputs = [
    numpy
  ];

  dontUseCmakeConfigure = true;

  checkInputs = [
    pytestCheckHook
  ];

  meta = with lib; {
    homepage = "https://github.com/scikit-hep/iminuit";
    description = "Python interface for the Minuit2 C++ library";
    license = with licenses; [ mit lgpl2Only ];
    maintainers = with maintainers; [ veprbl ];
  };
}
