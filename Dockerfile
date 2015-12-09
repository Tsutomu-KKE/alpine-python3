FROM alpine

ENV BLAS /usr/local/lib/libfblas.a
ENV LAPACK /usr/local/lib/liblapack.a
RUN apk add --update musl python3-dev freetype-dev make g++ gfortran wget && \
    cd /tmp && wget -q --no-check-certificate \
        https://raw.githubusercontent.com/catholabs/docker-alpine/master/blas.sh \
        https://raw.githubusercontent.com/catholabs/docker-alpine/master/blas.tgz \
        https://raw.githubusercontent.com/catholabs/docker-alpine/master/lapack.sh \
        https://raw.githubusercontent.com/catholabs/docker-alpine/master/lapack.tgz \
        https://raw.githubusercontent.com/catholabs/docker-alpine/master/make.inc \
        http://dl.ipafont.ipa.go.jp/IPAexfont/ipaexg00301.zip && \
    sh ./blas.sh && sh ./lapack.sh && \
    cp ~/src/BLAS/libfblas.a /usr/local/lib && \
    cp ~/src/lapack-3.5.0/liblapack.a /usr/local/lib && \
    pip3 install -U pip && \
    pip install numpy==1.9.3 && \
    pip install scipy matplotlib jupyter networkx pandas pulp \
        scikit-learn blist bokeh statsmodels seaborn dask sympy && \
    unzip -q ipaexg00301.zip && \
    mv ipaexg00301/ipaexg.ttf /usr/lib/python3.4/site-packages/matplotlib/mpl-data/fonts/ttf/ && \
    apk del python3-dev freetype-dev && \
    apk add python3 && \
    rm -rf /var/cache/apk/* /tmp/* /root/src/
CMD ["sh"]
