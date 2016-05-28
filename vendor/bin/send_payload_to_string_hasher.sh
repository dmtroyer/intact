#!/bin/sh

# The only argument that IronWorker passes to the executed process
# is payload.json via the PAYLOAD_FILE environment variable.
# Since StringHasher.exe only accepts a string as an argument,
# we have IronWorker execute this script. The script reads the payload file
# and passes those contents that as an argument to StringHasher.exe

mono StringHasher.exe "`cat $PAYLOAD_FILE`"
