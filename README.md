# Using rDNA inside rocker/rstudio container

This is a docker container that runs RStudio Server and has [rDNA](https://github.com/leifeld/dna) already set up 
correctly.

## Installation

1. Install Docker on your system: <https://docs.docker.com/install/linux/docker-ce/ubuntu/>

2. Run:

```bash
sudo docker run -d -p 8787:8787 jbgruber/rdna
```

3. Visit `localhost:8787` in your browser and log in with username:password 
as `rstudio:rstudio`.

4. Open the file `rDNA_demo.R` via RStudio's "Files" pane.

Use the "Files" pane to upload or download files to/from the virtual machine.

Note: Get more information about the underlying docker image of RStudio and 
common configuration options at
[github.com/rocker-org](https://github.com/rocker-org/rocker-versioned/tree/master/rstudio) or 
<https://github.com/rocker-org/rocker/wiki>.

### AWT Error

The current beta of DNA can not run on headless machines and exits with the 
error:


```
Error in .jnew("dna.export/Exporter", "sqlite", infile, "", "", verbose) : 
  java.awt.AWTError: Can't connect to X11 window server using ':0' as the value of the DISPLAY variable.
```

You can prevent this by linking the host's screen to the virtual framebuffer
running inside the virtual machine:

```bash
docker run -d \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /etc/localtime:/etc/localtime \
    -e DISPLAY=unix$DISPLAY \
    -p 8787:8787 \
    rdna
```
