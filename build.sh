#!/usr/bin/env bash
set -euo pipefail # stop at first failure

echo_big() {
    echo ""
    echo "############################################################################################"
    echo "$1"
    echo ""
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

DRIVERSDIR=$SCRIPTDIR/artifacts/database-drivers
echo "DRIVERSDIR: $DRIVERSDIR"

echo_big "Cleaning $BUILDIR..."
rm -rf $BUILDIR
mkdir $BUILDIR

# Create dest files
CONNECTORSDESTFILE=$BUILDIR/connectors.json
FILTERSDESTFILE=$BUILDIR/actorfilters.json
DRIVERSDESTFILE=$BUILDIR/drivers.json

echo "Creating $CONNECTORSDESTFILE..."
touch $CONNECTORSDESTFILE
echo "[" >> $CONNECTORSDESTFILE

echo "Creating $FILTERSDESTFILE..."
touch $FILTERSDESTFILE
echo "[" >> $FILTERSDESTFILE

echo "Creating $DRIVERSDESTFILE..."
touch $DRIVERSDESTFILE
echo "[" >> $DRIVERSDESTFILE

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

echo_big "Adding database drivers files into $DRIVERSDESTFILE..."

# Iterate over database drivers
addComma=false
for filename in $DRIVERSDIR/*.json; do
    if [[ "$addComma" = true ]]
    then
        echo "," >> $DRIVERSDESTFILE
    else
        addComma=true
    fi
    addToDestFile $filename $DRIVERSDESTFILE
done

# Close Json array
echo "]" >> $CONNECTORSDESTFILE
echo "]" >> $FILTERSDESTFILE
echo "]" >> $DRIVERSDESTFILE

echo_big "Build success!"
