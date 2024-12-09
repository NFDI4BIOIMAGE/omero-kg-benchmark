# BioHackathon2024-P4
Repository for project P4 "Endpoint Drafting and Testing" at the 2024 deNBI BioHackathon

## Benchmark environment
### Triplestores and SPARQL endpoints

## SPARQL client
All sparql queries are run through the Apache-Jena sparql client `rsparql`.

- Download apache jena 5.2.0: https://dlcdn.apache.org/jena/binaries/apache-jena-5.2.0.tar.gz

## SPARQL endpoints
All endpoints run on the X.X.X.137 server.

| Name     | Query                                        | Endpoint (for http requests)        | Comments |
|:---------|:---------------------------------------------|:------------------------------------|:---------|
| Ontop    | http://10.14.28.137:8080                     | http://10.14.28.137:8080/sparql     |          |
| Fuseki   | http://10.14.28.137:3030/#/dataset/OME/query | http://10.14.28.137:3030/OME/sparql |          |
| Virtuoso | http://10.14.28.137:8890/sparql              | http://10.14.28.137:8890/sparql     |          |
|          |                                              |                                     |          |

