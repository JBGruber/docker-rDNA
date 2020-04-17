## Start with the official rocker image (lightweight Debian) 

FROM rocker/verse

## Install git and rjava
RUN apt-get update; \
    apt-get install -y \
      git \
      default-jdk \
      r-cran-rjava \
      libudunits2-dev 
        
# Config rJava
RUN R CMD javareconf

# Install R packages and download bin
RUN Rscript -e "install.packages(c('remotes', 'statnet', 'xergm', 'cluster', 'igraph'))"; \
    Rscript -e "remotes::install_github('leifeld/dna/rDNA@*release', INSTALL_opts = '--no-multiarch')"; \
    Rscript -e "rDNA::dna_downloadJar()"; \
    rm -rf /tmp/downloaded_packages/
    
# Copy demo script
COPY rDNA_demo.R /home/rstudio/

CMD (/init)
