#!/bin/bash
# Load test service start script

# Set defaults
DURATION=${DURATION:-30s}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --duration)
      DURATION="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Set the script path
K6_SCRIPT="/app/scripts/continuous.js"
echo "Running continuous background load test (continuous.js)"

# Override the duration if specified
if [[ "$DURATION" != "30s" ]]; then
  export K6_DURATION=$DURATION
  echo "Using custom duration: $DURATION"
fi

# Set the K6_SCRIPT environment variable and run k6
export K6_SCRIPT
exec k6 run $K6_SCRIPT 