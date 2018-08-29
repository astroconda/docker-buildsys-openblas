#!/bin/bash
set -e
set -x

name="OpenBLAS"
version="0.3.2"
tarball="v${version}.tar.gz"
dest="${name}-${version}" # Ugh.
url="http://github.com/xianyi/${name}/archive/${tarball}"
prefix="/opt/OpenBLAS"

function pre()
{
    curl -LO "${url}"
    tar xf "${tarball}"
}

function build()
{
    pre
    pushd "${dest}"
        export LDFLAGS="-Wl,-rpath=$prefix/lib"
        make USE_OPENMP=1
        make install PREFIX="${prefix}" NO_STATIC=1
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
