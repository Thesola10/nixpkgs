{ lib, fetchPypi, buildPythonPackage
, gviz-api
, protobuf
, werkzeug
}:

buildPythonPackage rec {
  pname = "tensorboard_plugin_profile";
  version = "2.8.0";
  format = "wheel";

  src = fetchPypi {
    inherit pname version;
    format = "wheel";
    dist = "py3";
    python = "py3";
    sha256 = "sha256-WNZcl5lR52KMo7RseY4Q5YEwJqPs+6zDGc+I6+dmE0o=";
  };

  propagatedBuildInputs = [
    gviz-api
    protobuf
    werkzeug
  ];

  meta = with lib; {
    description = "Profile Tensorboard Plugin.";
    homepage = "http://tensorflow.org";
    license = licenses.asl20;
    maintainers = with maintainers; [ ndl ];
  };
}
