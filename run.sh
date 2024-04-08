#!/bin/bash

(cd flask_service && ./run.sh)
(cd go_service && ./run.sh)
(cd graalvm_service && ./run.sh)
(cd jvm_service && ./run.sh)

bal run report.bal
