#!/usr/bin/env sh

# Import .env configurations
. ${PWD}/.env
    

# Start Spark UI docker container
docker run -it --name spark_ui \
    -e SPARK_HISTORY_OPTS="$SPARK_HISTORY_OPTS \
        -Dspark.history.fs.logDirectory=$LOG_DIR \
        -Dspark.hadoop.fs.s3a.access.key=$AWS_ACCESS_KEY_ID \
        -Dspark.hadoop.fs.s3a.secret.key=$AWS_SECRET_ACCESS_KEY \
        -Dspark.hadoop.fs.s3a.session.token=$AWS_SESSION_TOKEN \
        -Dspark.hadoop.fs.s3a.aws.credentials.provider=org.apache.hadoop.fs.s3a.TemporaryAWSCredentialsProvider" \
    -p 18080:18080 \
    glue/sparkui:latest "/opt/spark/bin/spark-class org.apache.spark.deploy.history.HistoryServer"