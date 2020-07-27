FROM ubuntu
ARG ARG
# Build essential
RUN apt-get update && apt-get install -y build-essential curl

ENV RUSTUP_HOME=/opt/rust/rustup
ENV CARGO_HOME=/opt/rust/cargo

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable --profile default -y --no-modify-path

RUN echo 'export RUSTUP_HOME=$RUSTUP_HOME \
      \nexport CARGO_HOME=$CARGO_HOME \
      \nPATH=$PATH:$CARGO_HOME/bin' > /root/.bashrc

# Setting up the development environment
RUN useradd -ms /bin/bash -d /home/dev dev
RUN echo 'export RUSTUP_HOME=$RUSTUP_HOME \
      \nexport CARGO_HOME=$CARGO_HOME \
      \nPATH=$PATH:$CARGO_HOME/bin' > /home/dev/.bashrc
USER dev
WORKDIR /home/dev/
CMD [ "tail", "-f", "/dev/null" ]