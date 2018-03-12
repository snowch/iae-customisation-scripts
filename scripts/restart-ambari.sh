set -e # Make script fail if an error is encountered

# INTRODUCTION: This script is configures Analytics Engine with a 
#
# SCRIPT ARGUMENTS: This script requires one argument that must be set to 'HARD_AMBARI_RESTART'
#
# TODO: Future versions of this script will support different methods of restarting Ambari, e.g. 
#       https://stackoverflow.com/questions/48938878/how-to-determine-which-services-to-restart-after-a-configuration-change


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
