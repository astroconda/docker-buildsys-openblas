FROM astroconda/buildsys-vanilla
WORKDIR /build

COPY build_openblas.sh .
RUN ./build_openblas.sh

COPY build_cython.sh .
RUN ./build_cython.sh 3.5 \
 && ./build_cython.sh 3.6 \
 && ./build_cython.sh 3.7

COPY build_numpy.sh .
RUN ./build_numpy.sh 3.5 \
 && ./build_numpy.sh 3.6 \
 && ./build_numpy.sh 3.7

COPY build_scipy.sh .
RUN ./build_scipy.sh 3.5 \
 && ./build_scipy.sh 3.6 \
 && ./build_scipy.sh 3.7

WORKDIR /work
