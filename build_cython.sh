#!/bin/bash
set -e
set -x

version="0.28.5"
tarball="${version}.tar.gz"
dest="cython-${version}" # Ugh.
url="http://github.com/cython/cython/archive/${tarball}"
export PATH_OLD="${PATH}"

if [[ ! $1 ]]; then
    echo No argument passed. Need a version.
    exit 1
fi
export pylon="/opt/$1/bin"

function pre()
{
    export PATH="${pylon}:${PATH_OLD}"
    export OPENBLAS_ROOT="/opt/OpenBLAS"
    export PKG_CONFIG_PATH="${OPENBLAS_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}"
    export LDFLAGS="-Wl,-rpath=${OPENBLAS_ROOT}/lib"

    curl -LO "${url}"
    tar xf "${tarball}"
}

function build()
{
    pre
    pushd "${dest}"
        python setup.py install
    popd
    post
}

function post()
{
    rm -rf "${dest}"
    rm -rf "${tarball}"
    echo "All done."
}

# Main
build
