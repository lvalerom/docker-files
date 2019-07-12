from ubuntu
run apt-get update && apt-get install -y texlive-full
cmd [ "tail", "-f", "/dev/null" ]