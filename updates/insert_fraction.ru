insert {
  ?s ?p ?o }
where {
  service <http://10.14.28.137:8080/sparql> {
    select ?s ?p ?o where {
                     ?s ?p ?o.
                   }
                  limit 10
}
}
