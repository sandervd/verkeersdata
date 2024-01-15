FROM ontotext/graphdb:10.5.0
ADD ./start-with-repository.sh /opt/graphdb/dist/bin/
ADD ./repo-config.json /opt/graphdb/dist/bin/
ADD ./healthy.sh /opt/graphdb/dist/bin/

ENTRYPOINT [ "/opt/graphdb/dist/bin/start-with-repository.sh" ]
#ENTRYPOINT [ "/opt/graphdb/dist/bin/graphdb" ]