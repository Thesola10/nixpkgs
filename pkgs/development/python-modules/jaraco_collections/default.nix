{ buildPythonPackage, fetchPypi, setuptools-scm
, six, jaraco_classes, jaraco_text
}:

buildPythonPackage rec {
  pname = "jaraco.collections";
  version = "3.5.2";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-ByuT6zX55IUISFdVU05mo07xzISvKR/Sfzm0TUwN0sM=";
  };

  pythonNamespaces = [ "jaraco" ];

  doCheck = false;
  buildInputs = [ setuptools-scm ];
  propagatedBuildInputs = [ six jaraco_classes jaraco_text ];

  # break dependency cycle
  patchPhase = ''
    sed -i "/'jaraco.text',/d" setup.py
  '';
}
