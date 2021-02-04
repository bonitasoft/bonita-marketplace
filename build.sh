#!/usr/bin/env bash
set -euo pipefail # stop at first failure

echo_big() {
    echo "\n############################################################################################"
    echo "$1\n"
}

echo_big "Initializing variables..."

SCRIPTDIR=$(pwd)
echo "SCRIPTDIR: $SCRIPTDIR"

BUILDIR=$SCRIPTDIR/build
echo "BUILDIR: $BUILDIR"

CONNECTORSDIR=$SCRIPTDIR/artifacts/connectors
echo "CONNECTORSDIR: $CONNECTORSDIR"

FILTERSDIR=$SCRIPTDIR/artifacts/actor-filters
echo "FILTERSDIR: $FILTERSDIR"

echo_big "Cleaning $BUILDIR..."
rm -rf $BUILDIR
mkdir $BUILDIR

# Create dest files
CONNECTORSDESTFILE=$BUILDIR/connectors.json
FILTERSDESTFILE=$BUILDIR/actorfilters.json

echo "Creating $CONNECTORSDESTFILE..."
touch $CONNECTORSDESTFILE
echo "[" >> $CONNECTORSDESTFILE

echo "Creating $FILTERSDESTFILE..."
touch $FILTERSDESTFILE
echo "[" >> $FILTERSDESTFILE

addToDestFile() {
    echo "Adding $1..."
    cat $1 >> $2
}

echo_big "Adding connectors files into $CONNECTORSDESTFILE..."
# Iterate over connectors
addComma=false
for filename in $CONNECTORSDIR/*.json; do
    if [[ "$addComma" = true ]]
    then
        echo "," >> $CONNECTORSDESTFILE
    else
        addComma=true
    fi
    addToDestFile $filename $CONNECTORSDESTFILE
done

echo_big "Adding actor filter files into $FILTERSDESTFILE..."

# Iterate over actor filters
addComma=false
for filename in $FILTERSDIR/*.json; do
    if [[ "$addComma" = true ]]
    then
        echo "," >> $FILTERSDESTFILE
    else
        addComma=true
    fi
    addToDestFile $filename $FILTERSDESTFILE
done

# Close Json array
echo "]" >> $CONNECTORSDESTFILE
echo "]" >> $FILTERSDESTFILE

echo_big "Build success!"
