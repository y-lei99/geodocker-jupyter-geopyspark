FROM pangeo/pangeo-notebook:2019.12.04


# Set up Jupyter
RUN mkdir -p /home/dask/notebooks 
RUN conda install --quiet yes 'pip' && \
    jupyter nbextension enable --py widgetsnbextension
#COPY kernels/local/kernel.json /home/hadoop/.local/share/jupyter/kernels/pyspark/kernel.json

# Install GeoPySpark
RUN pip install --user protobuf==3.3.0 traitlets==4.3.2 "https://github.com/locationtech-labs/geopyspark/archive/python3.zip"

# Install Jars
#ADD https://s3.amazonaws.com/geopyspark-dependency-jars/geotrellis-backend-assembly-${GEOPYSPARK_VERSION}.jar /opt/jars/

USER root
#RUN chmod ugo+r /opt/jars/*
RUN chown -R 777 /home/dask/.local/share
USER $NB_USER

WORKDIR /tmp
CMD ["jupyterhub", "--no-ssl", "--Spawner.notebook_dir=/home/dask/notebooks"]
