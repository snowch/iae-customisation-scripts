set -e # Make script fail if an error is encountered

################################################################################
# INSTRUCTIONS: 
#
# 1. Retreive the customisation script paramters
# 2. Download and exectute customisation scripts for your workflow
#
################################################################################

# Retrieve customisation script parameters, for example, if you have:
# {
#     "target": "all",
#     "custom_actions": [{
#         "name": "action1",
#         ...
#         "script_params": ["MY_S3_ACCESS_KEY", "MY_S3_ENDPOINT", "MY_S3_SECRET_KEY", "HARD_AMBARI_RESTART"]
#     }]
# }

S3_ACCESS_KEY=$1
S3_ENDPOINT=$2
S3_SECRET_KEY=$3

AMBARI_RESTART_TYPE=$4

################################################################################
#
# Download and execute scripts.  Modify these to suit your workflow.
#
################################################################################

BASEURL=https://github.com/snowch/iae-customisation-scripts/raw/master/scripts

#
# Configure COS S3
#

wget -c $BASEURL/configure-cos-s3.sh
source configure-cos-s3.sh $S3_ACCESS_KEY $S3_ENDPOINT $S3_SECRET_KEY

#
# Install Apache Flink
#

wget -c $BASEURL/install-flink.sh
source install-flink.sh

#
# Perform ambari restart
#

wget -c $BASEURL/restart-ambari.sh
source restart-ambari.sh $AMBARI_RESTART_TYPE
