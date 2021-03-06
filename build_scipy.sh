#!/bin/bash
set -e
set -x

name="scipy"
version="1.1.0"
tarball="v${version}.tar.gz"
dest="${name}-${version}" # Ugh.
url="http://github.com/scipy/scipy/archive/${tarball}"
export PATH_OLD="${PATH}"

if [[ ! $1 ]]; then
    echo No argument passed. Need a version.
    exit 1
fi
export py_dest="/opt/$1/bin"

function pre()
{
    export PATH="${py_dest}:${PATH_OLD}"
    export OPENBLAS="/opt/OpenBLAS"
    export PKG_CONFIG_PATH="${OPENBLAS}/lib/pkgconfig:${PKG_CONFIG_PATH}"

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
