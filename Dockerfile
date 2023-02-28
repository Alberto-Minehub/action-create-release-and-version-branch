FROM amazonlinux:latest

RUN yum install -y aws-cli
RUN $(aws ecr get-login-password --region ap-east-1 | docker login --username AWS --password-stdin 764933444907.dkr.ecr.ap-east-1.amazonaws.com)

FROM 764933444907.dkr.ecr.ap-east-1.amazonaws.com/alpine:3.16.2

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
