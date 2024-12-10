# Sequentially run all queries
Run all 10 queries one after the other first on fuseki, then on ontop. Repeat 30 times.

```
for q in ??-*.rq; do
  echo "Wall (s),User (s),Sys (s)" > ${query}.ontop.timings.collected.csv
  echo "Wall (s),User (s),Sys (s)" > ${query}.fuseki.timings.collected.csv
done

for round in {1..30}; do
  echo "round=$round "
  for q in ??-*.rq; do
    echo -n "$q "
    ./timer.sh $query http://10.14.28.137:8080/sparql ontop 1
    ./timer.sh $query http://10.14.28.137:3030/OME/sparql fuseki 1
    cat ${query}.ontop.timings.csv | tail -1 >> ${query}.ontop.timings.collected.csv
    cat ${query}.fuseki.timings.csv | tail -1 >> ${query}.fuseki.timings.collected.csv
  done
done
```
Timings come out differently: for many queries, now fuseki is faster, ontop factor 2 slower.

[!img](facet_walltime.png)
