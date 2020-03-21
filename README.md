# docker-splunk
Splunk on docker container

Data Store
This Docker image has two data volumes:
```
/opt/splunk/etc - stores Splunk configurations, including applications and lookups
/opt/splunk/var - stores indexed data, logs and internal Splunk data
```

User
All Splunk processes by default runs as the splunk user. The user can be changed by setting the SPLUNK_USER env variable.

Ports
This Docker container exposes the following network ports:
```
8000/tcp - Splunk Web interface
8088/tcp - HTTP Event Collector
8088/tcp - Splunk Services
8191/tcp - Application Key Value Store
9997/tcp - Splunk receiving Port (not used by default) typically used by the Splunk Universal Forwarder
1514/tcp - Network Input (not used by default) typically used to collect syslog TCP data
```

Start a Splunk Enterprise container and mount volumes from host
```
docker run --name splunk --hostname splunk -p 8000:8000  -e "SPLUNK_START_ARGS=--accept-license" -v /opt/splunk/etc:/opt
```