#!/bin/bash
autossh -M 12399 -oPubkeyAuthentication=yes -oPasswordAuthentication=no -oLogLevel=error  -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -i ~/.ssh/home.pem -R 1111:localhost:22 client@example.com -p 22
