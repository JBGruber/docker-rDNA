## Start with the official rocker image (lightweight Debian) 

FROM rocker/rstudio:latest 

## Install git, supervisor, VNC, & X11 packages
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      bash \
      fluxbox \
      git \
      net-tools \
      novnc \
      socat \
      supervisor \
      x11vnc \
      xterm \
      xvfb

# Setup demo environment variables
ENV DISPLAY=:0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes# \
RUN_FLUXBOX=yes

# Setup Java and R Java
RUN apt-get install -y\
        default-jdk \
        r-cran-rjava \
        libudunits2-dev 
        
# Config rJava
RUN R CMD javareconf

# Install R packages
RUN Rscript -e "install.packages(c('remotes', 'statnet', 'xergm', 'cluster'))"
RUN installGithub.r igraph/rigraph \
    leifeld/dna/rDNA \
    && rm -rf /tmp/downloaded_packages/
    
# Download DNA.jar
RUN Rscript -e \
    "download.file('https://github.com/leifeld/dna/raw/master/manual/dna-2.0-beta20.jar', destfile = '/home/rstudio/dna-2.0-beta20.jar', mode = 'wb')"
    
# Copy demo script
COPY rDNA_demo.R /home/rstudio/

CMD (service xvfb start; DISPLAY=:0; export DISPLAY=:0; /init)
