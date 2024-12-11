# Dec. 11 2024
## Run 4: Query response time vs. number of triples
We first generated rdf.ttl files of reduced size with

```sparql
construct {?s ?p ?o} where {?s ?p ?o} limit <NTRIPLES>
```
`NTRIPLES` is a placeholder which takes on values of 1000, 2000, 5000, 10000, 20000, 50000, 100000, and 200000.

Starting with the 200k triples graph loaded into the fuseki triplestore,
we run 10 queries on the fuseki endpoint, repeat that sequence 10 times. Script is pasted below.

After each run, we drop the default graph
```sparql
drop default
```
and upload the next reduced graph.

### Script

```
#! /bin/bash

for query in ??-*.rq; do
    echo "Wall (s),User (s),Sys (s)" > $(basename ${query} .rq).fuseki.timings.collected.csv
done

for round in {1..10}; do
    echo "round=$round "
    for query in ??-*.rq; do
        echo "$query "

        echo fuseki
        ./timer.sh $query http://128.176.233.7:3030/OME/sparql fuseki 1
        cat $(basename ${query} .rq).fuseki.timings.csv | tail -1 >> $(basename ${query} .rq).fuseki.timings.collected.csv
    done
done
```

### Results
![](fuseki_clock_vs_ntriples_linear.png)
![](fuseki_clock_vs_ntriples_log.png)

The figures above show the measured query response time (Wall , User , and System clocks [^1])
as function of the number of triples loaded in the Fuseki
triplestore (top: linear x axis scale, right: log x axis scale). 
Each point is the average over 10 identical queries, the various queries are color coded. The shaded
areas mark  1 standard deviation above and below the marker.

#### Discussion
The observed query response time vary with the number of triples and the type of the query. The longest query response time (wall time) is measured for the "image properties" query, which retrieves all key-value annotations from all images. 
For very small graphs (1000 and 2000 triples), all measured response (wall) times coincide at approx. 1s.
Up to a certain graph size, each query's response time is at first independent of the graph size before it 
starts to increase
at approximately linear scale (query response wall time ~ number of triples).


[^1]: Wall time = time elapsed on a "wall" clock; User time = Sum of times that any CPU spends in user code within the process; System time: Sum of times that any CPU spends in system code within the process. See [this SO post for details](https://stackoverflow.com/questions/556405/what-do-real-user-and-sys-mean-in-the-output-of-time1).
