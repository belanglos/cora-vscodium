#! /bin/bash

VSCODIUM="cora-vscodium"

JS="cora-react-ts-test cora-react-client"
#JS_CONTAINER="cora-docker-jsclient "
JS_CONTAINER=""
ALL_JS=$JS" "$JS_CONTAINER



ALL=$VSCODIUM" "$ALL_JS
