FROM ubuntu
RUN apt-get update && apt-get -y install wget
RUN useradd -ms /bin/bash -d /home/dev dev
RUN chown dev:dev -R /home/dev
USER dev
ENV HOME /home/dev
WORKDIR /home/dev
RUN ["/bin/bash", "-c", "wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/miniconda.sh"]
RUN chmod 0755 $HOME/miniconda.sh
RUN ["/bin/bash", "-c", "$HOME/miniconda.sh -b -p $HOME/conda"]
ENV PATH="$HOME/conda/bin:$PATH"
RUN rm $HOME/miniconda.sh
RUN conda update -y conda
RUN conda install -y conda-build

WORKDIR /home/dev

CMD [ "tail", "-f", "/dev/null" ]
