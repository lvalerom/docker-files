FROM ubuntu:20.04
RUN apt-get update && apt-get -y install wget git gcc
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
#SHELL ["/bin/bash", "--login", "-c"]
RUN conda init bash

RUN git clone https://github.com/astropy/astroquery.git /home/dev/astroquery
RUN conda create --name astroquery
RUN echo "conda activate astroquery" > /home/dev/.bashrc
RUN conda install -n astroquery -y pip
RUN /home/dev/conda/envs/astroquery/bin/pip3 install -r /home/dev/astroquery/pip-requirements
RUN /home/dev/conda/envs/astroquery/bin/pip3 install six curl pytest-astropy pyVO astropy-healpix regions mocpy boto3
# pyregion APLpy
#RUN /home/dev/conda/envs/astroquery/bin/python /home/dev/astroquery/setup.py install

WORKDIR /home/dev

CMD [ "tail", "-f", "/dev/null" ]
