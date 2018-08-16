#!/bin/bash

set -e

cmd="$@"

HUB_STATUS_URL=${HUB_STATUS_URL};
TESTPATH=${TESTPATH};

while ! curl -sSL $HUB_STATUS_URL 2>&1 \
        | grep "ready" | grep "true" >/dev/null; do
    echo 'Waiting for the Selenium Grid'
    sleep 1
done

>&2 echo "Selenium Grid is up - executing test"

while ! test -f "$TESTPATH/pom.xml"; do
	# echo "waiting for mount to $TESTPATH" >&2
	inotifywait --quiet --timeout 2 --event create $TESTPATH/pom.xml >/dev/null || {
    (( $? == 2 )) && continue  ## inotify exit status 2 means timeout expired
    # echo "unable to sleep with inotifywait; doing unconditional 2-second loop" >&2
    sleep 2
  }
done

>&2 echo "Mount done!";

exec $cmd
