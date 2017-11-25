#!/bin/bash -xe
echo "ECS_CLUSTER=${cluster_id}" >> /etc/ecs/ecs.config
echo "ECS_ENGINE_TASK_CLEANUP_WAIT_DURATION=10m" >> /etc/ecs/ecs.config
yum update -y ecs-init
echo "DOCKER_STORAGE_OPTIONS=\"--storage-driver overlay2\"" > /etc/sysconfig/docker-storage
service docker restart
start ecs
yum install -y aws-cli
HOSTED_ZONE_ID=${hosted_zone_id}
AVAILABILITY_ZONE=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
IPV4=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
aws s3api get-object --bucket ${s3_template_bucket} --key upsert-resource-record-set.sh upsert-resource-record-set.sh
chmod 755 upsert-resource-record-set.sh
./upsert-resource-record-set.sh $AVAILABILITY_ZONE $IPV4 $HOSTED_ZONE_ID
