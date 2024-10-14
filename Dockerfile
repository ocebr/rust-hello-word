FROM ubuntu:22
USER root
RUN apt-get update && apt-get install -y curl libssl-dev gcc pkg-config && apt-get clean \
&& rm -rf /var/lib/apt/lists/*
ENV RUSTUP_HOME=/opt/rust/rustup
ENV CARGO_HOME=/opt/rust/cargo
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH=${PATH}:/opt/rust/cargo/bin
# For code Coverage
USER 1000
RUN  rustup component add llvm-tools-preview && cargo install grcov cargo-nextest cargo-audit
