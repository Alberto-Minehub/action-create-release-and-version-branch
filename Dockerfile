FROM 764933444907.dkr.ecr.ap-east-1.amazonaws.com/alpine:3.16.2

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
