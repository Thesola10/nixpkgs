{ lib
, buildPythonPackage
, pythonOlder
, fetchPypi
, importlib-metadata
, pyyaml
, python
}:

buildPythonPackage rec {
  pname = "markdown";
  version = "3.4.1";

  disabled = pythonOlder "3.6";

  format = "setuptools";

  src = fetchPypi {
    pname = "Markdown";
    inherit version;
    sha256 = "sha256-O4CQhrtu+tQWFW4AoNpm/kdhil1pGN1oj1P0DI5M/v8=";
  };

  propagatedBuildInputs = lib.optionals (pythonOlder "3.10") [
    importlib-metadata
  ];

  checkInputs = [ pyyaml ];

  checkPhase = ''
    ${python.interpreter} -m unittest discover
  '';

  pythonImportsCheck = [ "markdown" ];

  meta = with lib; {
    description = "A Python implementation of John Gruber's Markdown with Extension support";
    homepage = "https://github.com/Python-Markdown/markdown";
    license = licenses.bsd3;
    maintainers = with maintainers; [ dotlambda ];
  };
}
