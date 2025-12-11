#!/bin/bash
# Fix GCC at_quick_exit/quick_exit detection on macOS
#
# This script patches Homebrew's GCC installation to fix the incorrect
# detection of at_quick_exit and quick_exit C11 functions on macOS.
#
# Background:
# GCC's configure script incorrectly detects these functions as available
# on macOS, but they are not actually provided. This causes build failures
# when compiling code that uses libstdc++ features depending on these functions.
#
# The patch comments out the incorrect #define statements in c++config.h.
#
# References:
# - https://trac.macports.org/ticket/70341
# - https://github.com/microsoft/vcpkg/issues/47153
# - https://github.com/abseil/abseil-cpp/discussions/1807

set -e

HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix)}"
GCC_PREFIX="${HOMEBREW_PREFIX}/Cellar/gcc"

# Find the GCC version directory
if [ ! -d "$GCC_PREFIX" ]; then
    echo "Error: GCC not found at $GCC_PREFIX"
    echo "Please install GCC first: brew install gcc"
    exit 1
fi

GCC_VERSION=$(ls -1 "$GCC_PREFIX" | sort -V | tail -1)
if [ -z "$GCC_VERSION" ]; then
    echo "Error: No GCC version found in $GCC_PREFIX"
    exit 1
fi

# Determine architecture
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    ARCH_DIR="aarch64-apple-darwin*"
else
    ARCH_DIR="x86_64-apple-darwin*"
fi

# Find the c++config.h file
CONFIG_FILE=$(find "$GCC_PREFIX/$GCC_VERSION/include/c++" -name "c++config.h" -path "*/$ARCH_DIR/bits/*" 2>/dev/null | head -1)

if [ -z "$CONFIG_FILE" ]; then
    echo "Error: c++config.h not found for architecture $ARCH"
    exit 1
fi

# Check mode
if [ "$1" = "--check" ]; then
    if grep -q "^#define _GLIBCXX_HAVE_AT_QUICK_EXIT 1$" "$CONFIG_FILE" 2>/dev/null; then
        echo "Patch NOT applied - c++config.h has the buggy defines"
        exit 1
    else
        echo "Patch applied - c++config.h is fixed"
        exit 0
    fi
fi

echo "Found c++config.h at: $CONFIG_FILE"
echo "GCC version: $GCC_VERSION"

# Create backup
if [ ! -f "${CONFIG_FILE}.backup" ]; then
    echo "Creating backup..."
    cp "$CONFIG_FILE" "${CONFIG_FILE}.backup"
fi

# Check if already patched
if grep -q "^// PATCHED.*_GLIBCXX_HAVE_AT_QUICK_EXIT" "$CONFIG_FILE" 2>/dev/null; then
    echo "Already patched!"
    exit 0
fi

# Apply patch
echo "Applying patch..."

# Patch _GLIBCXX_HAVE_AT_QUICK_EXIT
sed -i.tmp 's/^#define _GLIBCXX_HAVE_AT_QUICK_EXIT 1$/\/\/ PATCHED: #define _GLIBCXX_HAVE_AT_QUICK_EXIT 1/' "$CONFIG_FILE"

# Patch _GLIBCXX_HAVE_QUICK_EXIT
sed -i.tmp 's/^#define _GLIBCXX_HAVE_QUICK_EXIT 1$/\/\/ PATCHED: #define _GLIBCXX_HAVE_QUICK_EXIT 1/' "$CONFIG_FILE"

# Clean up temp file
rm -f "${CONFIG_FILE}.tmp"

# Verify patch
if grep -q "^// PATCHED.*_GLIBCXX_HAVE_AT_QUICK_EXIT" "$CONFIG_FILE" && \
   grep -q "^// PATCHED.*_GLIBCXX_HAVE_QUICK_EXIT" "$CONFIG_FILE"; then
    echo "Patch applied successfully!"
    echo ""
    echo "You can now build code that depends on abseil/opentelemetry-cpp with GCC on macOS."
else
    echo "Warning: Patch may not have been applied correctly."
    echo "Please check $CONFIG_FILE manually."
    exit 1
fi
