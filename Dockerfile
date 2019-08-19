FROM rocker/shiny:3.6.0

LABEL maintainer "Branson Fox <bransonf@wustl.edu>"

# linx dependencies for R packages
RUN apt-get update && apt-get install -y \
        libudunits2-0 \
        libudunits2-dev \
        libgdal-dev \
        libssl-dev \
        libcurl4-openssl-dev \
        libcairo2-dev


# install R libraries
RUN R -e "install.packages(c('shinyWidgets','DT','ggplot2','viridis','tidycensus','dplyr','sf','magrittr','stringr', 'tigris','RColorBrewer','pushbar'))"


# copy app to image
RUN mkdir /root/choro
COPY choro /root/choro

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/choro', port = 3838, host = '0.0.0.0')"]

