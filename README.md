# Using rDNA inside rocker/rstudio container

This is a docker container that runs RStudio Server and has [rDNA](https://github.com/leifeld/dna) already set up 
correctly.

## Installation

1. Install Docker on your system: <https://docs.docker.com/install/linux/docker-ce/ubuntu/>

2. Run:

    `sudo docker run -d -p 8787:8787 jbgruber/rdna`

3. Visit `localhost:8787` in your browser and log in with username:password as `rstudio:rstudio`.

4. Open the file `rDNA_demo.R` via RStudio's "Files" pane.

Use the "Files" pane to upload or download files to/from the virtual machine.

Note: Get more information about the underlying docker image of RStudio and common configuration options at
[github.com/rocker-org](https://github.com/rocker-org/rocker-versioned/tree/master/rstudio) or 
<https://github.com/rocker-org/rocker/wiki>.
