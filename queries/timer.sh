#! /bin/bash

if test "$#" -neq 2 ]]; then
    echo("Usage: timer.sh QUERYFILE ENDPOINTURL")
fi

QUERY=$1
ENDPOINT=$2
NQUERIES=10
RESULTSFNAME=$(basename $QUERY .rq).timings.tsv

# Environment
TIME=/usr/bin/time
SPARQL=/opt/apache-jena/bin/rsparql

# Write header (overwrites previous results.)
echo "Wall (s),User (s),Sys(s)" > $RESULTSFNAME

# Run timer NQUERIES times
for (( i=1; i<NQUERIES; i++ )); {
    $TIME -f "%e,%U,%S" -a -o $RESULTSFNAME $SPARQL --service $ENDPOINT --query $QUERY
}

Write out mean and std.
python -c "import pandas; print(pandas.read_csv(\"${RESULTSFNAME}\").describe().loc[['mean', 'std']])"
