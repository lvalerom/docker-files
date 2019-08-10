FROM ubuntu
RUN apt-get update && apt-get -y install wget expect
ENV SCRIPTS_PATH /opt/scripts
RUN mkdir -p $SCRIPTS_PATH
RUN useradd -ms /bin/bash dev
RUN  echo '#!/usr/bin/expect \
	 \nspawn jupyter notebook --generate-config \
	 \nexpect "Overwrite " { \
	 \n\t\tsend "y\\r" { \
	 \n\t\texpect eof \
	 \n\t\t} \
	 \n\t} \
	 \nspawn jupyter notebook password \
	 \nexpect "Enter password:" { \
	 \n\tsend "dev\\r" \
	 \n\texpect "Verify" { \
	 \n\t\tsend "dev\\r" \
	 \n\t\texpect eof \
	 \n\t\t} \
	 \n\t}' >> $SCRIPTS_PATH/config.exp
RUN echo '#!/bin/bash \
	\njupyter notebook --ip 0.0.0.0 > ~/notebook.log 2>&1' >> $SCRIPTS_PATH/start.sh
RUN chmod +x $SCRIPTS_PATH/config.exp
RUN chmod +x $SCRIPTS_PATH/start.sh
RUN ln -s $SCRIPTS_PATH/start.sh /usr/local/bin/start_notebook
RUN ln -s $SCRIPTS_PATH/config.exp /usr/local/bin/config_notebook
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
RUN conda install -y -c anaconda binstar
RUN conda install -y jupyter
RUN config_notebook
RUN mkdir $HOME/dev
WORKDIR /home/dev/dev
EXPOSE 8888
CMD [ "/usr/local/bin/start_notebook" ]