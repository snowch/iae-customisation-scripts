# INTRODUCTION: This script is configures Analytics Engine with a 
#
# VARIABLES: This script requires the following environment variables to be set:
# 
#    S3_ACCESS_KEY
#    S3_ENDPOINT
#    S3_SECRET_KEY

set -e # Make script fail if an error is encountered

if [ ! -z $S3_ACCESS_KEY ]
then
    echo "ERROR: Mandatory environment variable S3_ACCESS_KEY was not found.  Exiting."
    exit 1
fi

if [ ! -z $S3_ENDPOINT ]
then
    echo "ERROR: Mandatory environment variable S3_ENDPOINT was not found.  Exiting."
    exit 1
fi

if [ ! -z $S3_SECRET_KEY ]
then
    echo "ERROR: Mandatory environment variable S3_SECRET_KEY was not found.  Exiting."
    exit 1
fi
    

if [ "x$NODE_TYPE" == "xmanagement-slave2" ]
then
    echo $AMBARI_USER:$AMBARI_PASSWORD:$AMBARI_HOST:$AMBARI_PORT:$CLUSTER_NAME

    echo "Node type is xmanagement hence updating ambari properties"
    /var/lib/ambari-server/resources/scripts/configs.sh -u $AMBARI_USER -p $AMBARI_PASSWORD -port $AMBARI_PORT -s set $AMBARI_HOST $CLUSTER_NAME core-site "fs.cos.myservicename.access.key" $S3_ACCESS_KEY
    /var/lib/ambari-server/resources/scripts/configs.sh -u $AMBARI_USER -p $AMBARI_PASSWORD -port $AMBARI_PORT -s set $AMBARI_HOST $CLUSTER_NAME core-site "fs.cos.myservicename.endpoint" $S3_ENDPOINT
    /var/lib/ambari-server/resources/scripts/configs.sh -u $AMBARI_USER -p $AMBARI_PASSWORD -port $AMBARI_PORT -s set $AMBARI_HOST $CLUSTER_NAME core-site "fs.cos.myservicename.secret.key" $S3_SECRET_KEY
fi
