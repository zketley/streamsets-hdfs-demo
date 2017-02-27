FROM sequenceiq/hadoop-docker:2.7.1

# User to create
ENV USER      sdc
ENV USERGROUP hadoopusers

# Create the user
RUN groupadd -f $USERGROUP
RUN useradd -g hadoopusers sdc
RUN mkdir -p /tmp/hadoop-sdc
RUN chown $USER:$USERGROUP /tmp/hadoop-sdc
RUN chmod 777 /tmp/hadoop-sdc

# Create the HDFS user dir
RUN service sshd start && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfsadmin -safemode wait && $HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /user/$USER && $HADOOP_PREFIX/bin/hdfs dfs -chown -R $USER:$USERGROUP /user/$USER

# Create a dir for the streamsets output files
RUN service sshd start && $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh && $HADOOP_PREFIX/sbin/start-dfs.sh && $HADOOP_PREFIX/bin/hdfs dfsadmin -safemode wait && $HADOOP_PREFIX/bin/hdfs dfs -mkdir -p /opt/files/destination && $HADOOP_PREFIX/bin/hdfs dfs -chown -R $USER:$USERGROUP /opt/files/destination
