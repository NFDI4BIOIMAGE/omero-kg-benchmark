#! /bin/bash

for query in ??-*.rq; do
    echo "Wall (s),User (s),Sys (s)" > $(basename ${query} .rq).ontop.timings.collected.csv
    echo "Wall (s),User (s),Sys (s)" > $(basename ${query} .rq).fuseki.timings.collected.csv
    echo "Wall (s),User (s),Sys (s)" > $(basename ${query} .rq).virtuoso.timings.collected.csv
done

for round in {1..30}; do
    echo "round=$round "
    for query in ??-*.rq; do
        echo "$query "

        echo ontop
        ./timer.sh $query http://10.14.28.137:8080/sparql ontop 1
        cat $(basename ${query} .rq).ontop.timings.csv | tail -1 >> $(basename ${query} .rq).ontop.timings.collected.csv

        echo fuseki
        ./timer.sh $query http://10.14.28.137:3030/OME/sparql fuseki 1
        cat $(basename ${query} .rq).fuseki.timings.csv | tail -1 >> $(basename ${query} .rq).fuseki.timings.collected.csv

        echo virtuoso
        ./timer.sh $query http://10.14.28.137:8890/sparql virtuoso 1
        cat $(basename ${query} .rq).virtuoso.timings.csv | tail -1 >> $(basename ${query} .rq).virtuoso.timings.collected.csv

    done
done
