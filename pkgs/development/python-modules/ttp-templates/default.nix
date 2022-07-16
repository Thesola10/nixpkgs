{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
}:

buildPythonPackage rec {
  pname = "ttp-templates";
  version = "0.3.1";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "dmulyalin";
    repo = "ttp_templates";
    rev = "refs/tags/${version}";
    hash = "sha256-35Ej76E9qy5EY41Jt2GDCldyXq7IkdqKxVFrBOJh9nE=";
  };

  postPatch = ''
    # Drop circular dependency on ttp
    substituteInPlace setup.py \
      --replace '"ttp>=0.6.0"' ""
  '';

  # Circular dependency on ttp
  doCheck = false;

  meta = with lib; {
    description = "Template Text Parser Templates collections";
    homepage = "https://github.com/dmulyalin/ttp_templates";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
