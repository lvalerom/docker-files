from debian:9
# Using debian so it does not prompt us with the geographic area
# There are other ways to fix that like using an expect script
#run apt-get update && apt-get install -y texlive-full
run apt-get update && apt-get install -y texlive texlive-latex-extra texlive-fonts-extra

# Usage:
# docker run -dit --name NAME -v /path/to/your/latex:/any/path IMAGE:TAG
# Inside the container run: pdflatex DOCUMENT.tex
# In one command:
# docker run --rm -v "$PWD":/usr/src/project -w /usr/src/project IMAGE:TAG pdflatex DOCUMENT.tex

# Optional command to prevent the container to stop
cmd [ "tail", "-f", "/dev/null" ]