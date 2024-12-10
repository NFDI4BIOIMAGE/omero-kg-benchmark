# BioHackathon2024-P4
Repository for project P4 "Endpoint Drafting and Testing" at the 2024 deNBI BioHackathon

## Benchmark environment
### Triplestores and SPARQL endpoints
All endpoints run on the X.X.X.137 server.

| Name     | Query form                                   | Endpoint (http API)                 | Comments |
|:---------|:---------------------------------------------|:------------------------------------|:---------|
| Ontop    | http://10.14.28.137:8080                     | http://10.14.28.137:8080/sparql     |          |
| Fuseki   | http://10.14.28.137:3030/#/dataset/OME/query | http://10.14.28.137:3030/OME/sparql |          |
| Virtuoso | http://10.14.28.137:8890/sparql              | http://10.14.28.137:8890/sparql     |          |

## SPARQL client
### Apache-Jena 
- Download:  https://dlcdn.apache.org/jena/binaries/apache-jena-5.2.0.tar.gz
- Unpack into a directory and append *\/dir\/to\/apache-jena-5.2.0\/bin\/* to $PATH (on \*N\*X.) 

### Other clients
list download link, installation and usage instruction here.

## Queries
*queries\/* contains a number of SPARQL query files. They can be run on any of the endpoints listed above :
```
rsparql --service http://10.14.28.137:8080/sparql --query 01-list_of_attributes.rq
```

## Timing
The script *queries\/timer.sh* runs a given query N times, measure wall clock, user, and system time
and report the resulting statistics. Timings will be saved to disk.
Usage (must be in the *queries\/* directory):
```
./timer.sh QUERY ENDPOINTURL ENDPOINTNAME NQUERIES
```

##### Example
```
cd queries
./timer.sh 01-list_of_attributes.rq http://10.14.28.137:8080/sparql ontop 100
```
This would run the query *01-list_of_attributes.rq* 
on the ontop endpoint and write results to *01-list_of_attributes.ontop.timings.csv*.


### Timing analysis
The notebook *queries\/analyze_timings.ipynb* loads all timing csv data, performs
some descriptive statistics and renders a number of plots. Adjust to your liking. Required python packages: `pandas, seaborn, matplotlib`.

## Mappings
Mappings are defined in the [omero-ontop-mappings repo](https://github.com/German-BioImaging/omero-ontop-mappings). The repo is cloned on the X.X.X.137 server. Ontop runs inside a `screen` session and normally restarts after a change to
the mappings, ontology, or config. It may become neccessary to restart ontop in case of syntactical errors in any of these files. To (re-)launch the ontop server:
```
screen -dr ontop
cd /home/ubuntu/repos/omero-ontop-mappings/hack24
./run-ontop.sh
```

To leave the screen session press and hold <kbd>CTRL</kbd>, press and release <kbd>a</kbd>, press and release <kbd>d</kbd>, release <kbd>CTRL</kbd>. This brings you back into your login shell. You can then logout from the server, the screen session will continue in the background.

## Further reading
https://medium.com/wallscope/comparing-linked-data-triplestores-ebfac8c3ad4f


# Logbook
## Dec. 10 2024
- executing all queries in *[queries\/](queries/)* from remote via vpn on the X.X.X.137 Muenster server.
- checked all queries can be executed.
- query 09 failed, moved it to *queries\/query_foundry\/*.
- observed that queries run after the test respond faster, suspects there is some caching going on.
- results are saved in *queries\/saved_runs/20241210T091800*
- run metadata in readme.md in than directory.
- shell command for ontop:
```
cd queries
for q in ??-*.rq; do ./timer.sh $query http://10.14.28.137:8080/sparql ontop 30
```
- shell command for fuseki
```
cd queries
for q in ??-*.rq; do ./timer.sh $query http://10.14.28.137:3030/OME/sparql ontop 30
```

[!img](queries/saved_runs/20241210T091800/facet_walltime.png)
