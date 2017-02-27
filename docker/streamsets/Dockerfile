FROM streamsets/datacollector:2.3.0.0

# Build time argument to install packages
ARG PACKAGES_TO_INSTALL=streamsets-datacollector-hdp_2_5-lib,streamsets-datacollector-jython_2_7-lib

# Install the packages
RUN if [[ ! -z $PACKAGES_TO_INSTALL ]]; then $SDC_DIST/bin/streamsets stagelibs -install=$PACKAGES_TO_INSTALL ; fi

# Setup the directory tree for the taxi tutorial
# https://streamsets.com/documentation/datacollector/latest/help/#Tutorial/BeforeYouBegin.html#concept_hg5_j2p_ms
USER root
ENV FILES_BASE_DIR /opt/files
ENV TUTORIAL_BASE_DIR=$FILES_BASE_DIR/tutorial
RUN mkdir -p $TUTORIAL_BASE_DIR/origin $TUTORIAL_BASE_DIR/destination $TUTORIAL_BASE_DIR/error
COPY nyc_taxi_data.csv $TUTORIAL_BASE_DIR/origin
RUN chown -R $SDC_USER:$SDC_USER $FILES_BASE_DIR
USER $SDC_USER
