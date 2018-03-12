set -e # Make script fail if an error is encountered

# INTRODUCTION: This script is configures Analytics Engine with a 
#
# VARIABLES: This script requires the following arguments
# 
#    S3_ACCESS_KEY
#    S3_ENDPOINT
#    S3_SECRET_KEY


if [ "$#" -ne 3 ]; then
    echo "ERROR: Expected three program argumens (S3_ACCESS_KEY, S3_ENDPOINT, S3_SECRET_KEY)"
    exit 1
fi

S3_ACCESS_KEY=$1
S3_ENDPOINT=$2
S3_SECRET_KEY=$3    

if [ "x$NODE_TYPE" == "xmanagement-slave2" ]
then
    echo $AMBARI_USER:$AMBARI_PASSWORD:$AMBARI_HOST:$AMBARI_PORT:$CLUSTER_NAME

    echo "Node type is xmanagement hence updating ambari properties"
    /var/lib/ambari-server/resources/scripts/configs.sh -u $AMBARI_USER -p $AMBARI_PASSWORD -port $AMBARI_PORT -s set $AMBARI_HOST $CLUSTER_NAME core-site "fs.cos.myservicename.access.key" $S3_ACCESS_KEY
    /var/lib/ambari-server/resources/scripts/configs.sh -u $AMBARI_USER -p $AMBARI_PASSWORD -port $AMBARI_PORT -s set $AMBARI_HOST $CLUSTER_NAME core-site "fs.cos.myservicename.endpoint" $S3_ENDPOINT
    /var/lib/ambari-server/resources/scripts/configs.sh -u $AMBARI_USER -p $AMBARI_PASSWORD -port $AMBARI_PORT -s set $AMBARI_HOST $CLUSTER_NAME core-site "fs.cos.myservicename.secret.key" $S3_SECRET_KEY
fi
