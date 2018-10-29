#!/bin/bash -e

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd tests && pwd )"

freeze_period_constant_2s='constexpr static uint32_t FREEZE_PERIOD_IN_SECONDS = 2; // NEVER MERGE LIKE THIS'
freeze_period_constant_6M='constexpr static uint32_t FREEZE_PERIOD_IN_SECONDS = 3 * 24 * 60 * 60;'

set +e
result=`cat $ROOT/../include/forum.hpp | grep "${freeze_period_constant_2s}"`
exit_code=$?
if [[ $exit_code != 0 ]]; then
    echo "To correctly run all tests, the FREEZE_PERIOD_IN_SECONDS constant must be set to 2 seconds."
    echo "Constant definition should look like this in 'include/forum.hpp' file:"
    echo ""
    echo "${freeze_period_constant_2s}"
    echo ""
    exit 1
fi
set -e

echo "Building"
sh $ROOT/../build.sh

# Trap exit signal and closes docker instance
trap "sh $ROOT/../stop.sh" EXIT

echo "Launching 'nodeos' instance"
sh $ROOT/../run.sh

echo "Testing"
sh $ROOT/all.sh

echo "Tests completed"
echo "Don't forget to change back the freeze period in 'include/forum.hpp' file to:"
echo "${freeze_period_constant_6M}"
echo ""