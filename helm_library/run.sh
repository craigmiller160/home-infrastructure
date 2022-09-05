#!/bin/sh

#helm registry login dev-nexus-craigmiller160.ddns.net
helm package ./app_library
#helm push app_library:0.1.0 dev-nexus-craigmiller160.ddns.net/repository/helm-private/app_library

curl -u $NEXUS_USER:$NEXUS_PASSWORD https://dev-nexus-craigmiller160.ddns.net/repository/helm-private/ --upload-file app_library-0.1.0.tgz