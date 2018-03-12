set -e # Make script fail if an error is encountered

################################################################################
# INSTRUCTIONS: 
#
# 1. Retreive the customisation script paramters
# 2. Download and exectute customisation scripts for your workflow
#
################################################################################

# Retrieve customisation script parameters, for example:
# {
#     "target": "all",
#     "custom_actions": [{
#         "name": "action1",
#         ...
#         "script_params": ["MY_S3_ACCESS_KEY", "MY_S3_ENDPOINT", "MY_S3_SECRET_KEY"]
#     }]
# }

export S3_ACCESS_KEY=$1
export S3_ENDPOINT=$2
export S3_SECRET_KEY=$3

################################################################################
#
# Download and execute scripts
#
################################################################################

BASEURL=https://github.com/snowch/iae-customisation-scripts/raw/master/scripts

#
# Configure COS S3
#

wget -c $BASEURL/configure-cos-s3.sh && source configure-cos-s3.sh

#
# Perform a hard ambari restart
#

wget -c $BASEURL/restart-ambari.sh && source restart-ambari.sh hard
