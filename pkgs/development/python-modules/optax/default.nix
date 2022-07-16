{ absl-py
, buildPythonPackage
, chex
, dm-haiku
, fetchFromGitHub
, jaxlib
, lib
, numpy
, pytest-xdist
, pytestCheckHook
, tensorflow
, tensorflow-datasets
}:

buildPythonPackage rec {
  pname = "optax";
  version = "0.1.3";

  src = fetchFromGitHub {
    owner = "deepmind";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-XAYztMBQpLBHNuNED/iodbwIMJSN/0GxdmTGQ5jD9Ws=";
  };

  buildInputs = [ jaxlib ];

  propagatedBuildInputs = [
    absl-py
    chex
    numpy
  ];

  checkInputs = [
    dm-haiku
    pytest-xdist
    pytestCheckHook
    tensorflow
    tensorflow-datasets
  ];

  pythonImportsCheck = [
    "optax"
  ];

  disabledTestPaths = [
    # Requires `flax` which depends on `optax` creating circular dependency.
    "optax/_src/equivalence_test.py"
    # See https://github.com/deepmind/optax/issues/323.
    "examples/lookahead_mnist_test.py"
  ];

  meta = with lib; {
    description = "Optax is a gradient processing and optimization library for JAX.";
    homepage = "https://github.com/deepmind/optax";
    license = licenses.asl20;
    maintainers = with maintainers; [ ndl ];
  };
}
