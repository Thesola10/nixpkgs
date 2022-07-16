{ stdenv
, lib
, buildPythonPackage
, fetchPypi
, pytestCheckHook
, cachetools
, cryptography
, flask
, freezegun
, mock
, oauth2client
, pyasn1-modules
, pyu2f
, pytest-localserver
, responses
, rsa
}:

buildPythonPackage rec {
  pname = "google-auth";
  version = "2.9.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-FCkvo0KfK7HpmGJVTN4e5zDWhA664GeBTT0V2FScCIg=";
  };

  propagatedBuildInputs = [
    cachetools
    pyasn1-modules
    rsa
    pyu2f
  ];

  checkInputs = [
    cryptography
    flask
    freezegun
    mock
    oauth2client
    pytestCheckHook
    pytest-localserver
    responses
  ];

  pythonImportsCheck = [
    "google.auth"
    "google.oauth2"
  ];

  disabledTestPaths = [
    # Disable tests related to pyopenssl
    "tests/transport/test__mtls_helper.py"
    "tests/transport/test_requests.py"
    "tests/transport/test_urllib3.py"
  ];

  meta = with lib; {
    description = "Google Auth Python Library";
    longDescription = ''
      This library simplifies using Google’s various server-to-server
      authentication mechanisms to access Google APIs.
    '';
    homepage = "https://github.com/googleapis/google-auth-library-python";
    changelog = "https://github.com/googleapis/google-auth-library-python/blob/v${version}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ SuperSandro2000 ];
  };
}
