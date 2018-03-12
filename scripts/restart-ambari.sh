set -e # Make script fail if an error is encountered

# INTRODUCTION: This script is configures Analytics Engine with a 
#
# VARIABLES: This script requires the following arguments
# 
#    S3_ACCESS_KEY
#    S3_ENDPOINT
#    S3_SECRET_KEY


if [ "$#" -ne 1 ]; 
then
    echo "ERROR: Expected mandatory program argument 'HARD_AMBARI_RESTART'"
    exit 1
fi

AMBARI_RESTART_TYPE=$1

if [ "$AMBARI_RESTART_TYPE" == "HARD_AMBARI_RESTART" ]; 
then
    echo "Stop and Start ALL Services"
    curl -v --user $AMBARI_USER:$AMBARI_PASSWORD -H "X-Requested-By: ambari" -i -X PUT -d '{"RequestInfo": {"context": "Stop All Services via REST"}, "ServiceInfo": {"state":"INSTALLED"}}' https://$AMBARI_HOST:$AMBARI_PORT/api/v1/clusters/$CLUSTER_NAME/services
    sleep 200

    curl -v --user $AMBARI_USER:$AMBARI_PASSWORD -H "X-Requested-By: ambari" -i -X PUT -d '{"RequestInfo": {"context": "Start All Services via REST"}, "ServiceInfo": {"state":"STARTED"}}' https://$AMBARI_HOST:$AMBARI_PORT/api/v1/clusters/$CLUSTER_NAME/services
    sleep 700
else
   echo "ERROR: Unknown Ambari restart type '$AMBARI_RESTART_TYPE'"
fi
