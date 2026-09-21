#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export PYTHONPATH="$ROOT_DIR${PYTHONPATH:+:$PYTHONPATH}"
export PYTHONNOUSERSITE="${PYTHONNOUSERSITE:-1}"
exec "${MANTIS_PYTHON_BIN:-python3}" -c "from mantis_tools.repair_dataset_metadata import main; raise SystemExit(main())" "$@"
