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
- Unpack into a directory and append */dir/to/apache-jena-5.2.0/bin/* to $PATH (on \*N\*X.) 

### Other clients
list download link, installation and usage instruction here.

## Queries
/queries\// contains a number of SPARQL query files. They can be run against any of the endpoints listed above :
```
rsparql --service http://10.14.28.137:8080/sparql --query 01-list_of_attributes.rq
```

## Timing
The script /queries\/timer.sh/ can be run to run a given query N times, measure wall clock, user, and system time
and report the results statistics. Timings will be saved to disk.
Usage (must be in the /queries\// directory):
```
./timer.sh QUERY ENDPOINTURL ENDPOINTNAME NQUERIES
```

##### Example
```
cd queries
./timer.sh 01-list_of_attributes.rq http://10.14.28.137:8080/sparql ontop 100
```
This would run the query /01-list_of_attributes.rq/ 
on the ontop endpoint and write results to `01-list_of_attributes.ontop.timings.csv`.


### Timing analysis
The notebook /queries\/analyze_timings.ipynb/ loads all timing csv data, performs
some descriptive statistics and renders a number of plots. Adjust to your liking. Required python packages: `pandas, seaborn, matplotlib`.

## Mappings
Mappings are defined in the [omero-ontop-mappings repo](https://github.com/German-BioImaging/omero-ontop-mappings). The repo is cloned on the X.X.X.137 server. Ontop runs inside a `screen` session and normally restarts after a change to
the mappings, ontology, or config. It may become neccessary to restart ontop in case of syntactical errors in any of these files. To (re-)launch the ontop server:
```
screen -dr ontop
cd /home/ubuntu/repos/omero-ontop-mappings/hack24
./run-ontop.sh
```

