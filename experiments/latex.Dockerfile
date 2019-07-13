from debian:9
# Using debian so it does not prompt us with the geographic area
# There are other ways to fix that like using an expect script
run apt-get update && apt-get install -y texlive-full
cmd [ "tail", "-f", "/dev/null" ]