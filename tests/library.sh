export CONTRACT=eosioforum

boot() {
    return 0
}

print_config() {
    echo "Config"
    echo " Contract: ${CONTRACT}"
}

# usage: action_ok <action> <permission> <json>
action_ok() {
    info -n "Pushing OK action '$1 ($2)' ... "
    output=`cleos push action -f --json ${CONTRACT} $1 "${3}" --permission $2 2>&1`

    exit_code=$?
    if [[ $exit_code != 0 ]]; then
        error "failure (command failed, expecting success)"
        println $output
        exit $exit_code
    fi

    success "success"
}

# usage: action_ko <action> <permission> <json> <output_pattern>
action_ko() {
    info -n "Pushing KO action '$1 ($2)' ... "
    output=`cleos push action -f --json ${CONTRACT} $1 "${3}" --permission $2 2>&1`

    exit_code=$?
    if [[ $exit_code == 0 ]]; then
        error "failure (command succeed, expecting failure)"
        println $output
        exit $exit_code
    fi

    if [[ ! $output =~ "$4" ]]; then
        error "failure (message not matching '$4')"
        println $output
        exit 1
    fi

    success "success"
}

# usage: table_row <table> <scope> [<pattern> ...]
table_row() {
    info -n "Checking table '$1 ($2)' ... "
    output=`cleos get table -l 1000 ${CONTRACT} $2 $1 2>&1 | tr -d '\n' | sed 's/  */ /g'`

    exit_code=$?
    if [[ $exit_code != 0 ]]; then
        error "failure (retrieval failed)"
        println $output
        exit $exit_code
    fi

    shift; shift;

    for var in "$@"; do
        if [[ $var =~ ^! ]]; then
            if [[ $output =~ "${var:1}" ]]; then
                error "failure (rows matching '${var:1}', should not)"
                println $output
                exit 1
            fi

            success -n "(not '${var:1}' OK) "
        else
            if [[ ! $output =~ "$var" ]]; then
                error "failure (rows not matching '$var')"
                println $output
                exit 1
            fi

            success -n "('$var' OK) "
        fi
    done

    success "success"
}

BROWN='\033[0;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

info() {
    if [[ $1 != "-n" ]]; then println $BROWN "${@}"; else shift; print $BROWN "${@}"; fi
}

success() {
    if [[ $1 != "-n" ]]; then println $GREEN "${@}"; else shift; print $GREEN "${@}"; fi
}

error() {
    if [[ $1 != "-n" ]]; then println $RED "${@}"; else shift; print $RED "${@}"; fi
}

# usage: print $color [<messages> ...]
print() {
    color=$1; shift;

    printf "${color}${@}${NC}"
}

# usage: println $color [<messages> ...]
println() {
    print $@
    printf "\n"
}
