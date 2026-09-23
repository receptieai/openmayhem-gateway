FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    build-essential clang libclang-dev cmake pkg-config \
    git curl unzip nodejs npm ca-certificates bash \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app
RUN git clone https://github.com/Trac-Systems/openmayhem.git .
RUN ./install.sh --from-source

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV HOME=/data
EXPOSE 11435

ENTRYPOINT ["/entrypoint.sh"]
