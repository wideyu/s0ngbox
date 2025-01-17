FROM alpine

COPY ./content /workdir/

ENV PORT=3000
ENV SecretPATH=/mypath
ENV PASSWORD=password
ENV WG_MTU=1408
ENV BLOCK_QUIC_443=true
ENV CLASH_MODE=rule

RUN apk add --no-cache caddy runit jq tor bash python3 python3-dev py3-pip libffi-dev openssl-dev gcc musl-dev libxml2 libxml2-dev libxslt-dev \
    && bash /workdir/install.sh \
    && rm /workdir/install.sh \
    && chmod +x /workdir/service/*/run \
    && ln -s /workdir/service/* /etc/service/

EXPOSE 3000

ENTRYPOINT ["runsvdir", "/etc/service"]
