#!/bin/bash
# Output cloud controller events within a date range
die() {
    printf '%s\n' "$1" >&2
    exit 1
}

# Initialize all the option variables.
# This ensures we are not contaminated by variables from the environment.
org=
space=
verbose=0

# Define usage
function usage {
    cat <<EOM
Usage: 
  $(basename "$0") -s <date> -e <date>
      
  -s|--startdate <text> ISO-8601 date
  -e|--enddate   <text> ISO-8601 date
  -h|--help                   
Examples:
  $ $(basename "$0") -s "2019-10-23T00:00:00Z" -e 2019-10-24T00:00:00Z 
EOM
    exit 2
}

# Process options
while :; do
    case $1 in
        -\?|--help)
            usage               # Display a usage synopsis.
            exit
            ;;
        -s|--startdate)       # Takes an option argument; ensure it has been specified.
            if [ "$2" ]; then
                startdate=$2
                shift
            else
                die 'ERROR: "--startdate" requires a non-empty option argument.'
            fi
            ;;
        --startdate=?*)
            startdate=${1#*=}   # Delete everything up to "=" and assign the remainder.
            ;;
        --startdate=)           # Handle the case of an empty --startdate=
            die 'ERROR: "--startdate" requires a non-empty option argument.'
            ;;
        -e|--enddate)           # Takes an option argument; ensure it has been specified.
            if [ "$2" ]; then
                enddate=$2
                shift
            else
                die 'ERROR: "--enddate" requires a non-empty option argument.'
            fi
            ;;
        --enddate=?*)
            enddate=${1#*=}     # Delete everything up to "=" and assign the remainder.
            ;;
        --enddate=)             # Handle the case of an empty --enddate=
            die 'ERROR: "--enddate" requires a non-empty option argument.'
            ;;
       -v|--verbose)
            verbose=$((verbose + 1))  # Each -v adds 1 to verbosity.
            ;;
        --)                      # End of all options.
            shift
            break
            ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)                       # Default case: No more options, so break out of the loop.
            break
    esac

    shift
done

# If no org parameter exit
if [ -z $startdate ] && [ -z $enddate ]; then
   usage
fi

# Page through api call results
function load_all_pages {
    url="$1"
    data=""
    until [ "$url" == "null" ]; do
        resp=$(cf curl "$url")
        data+=$(echo "$resp" | jq .resources)
        url=$(echo "$resp" | jq -r .next_url)
    done
    # dump the data
    echo "$data" | jq .[] | jq -s
}


load_all_pages "/v2/events?q=timestamp>${startdate}&q=timestamp<${enddate}&order-by=timestamp"
