# Module prometheus-format

Format prometheus metrics to text of Extract of
https://opam.ocaml.org/packages/prometheus-app/ see
https://github.com/mirage/prometheus/blob/master/app/prometheus_app.ml

# Module prometheus-push

Create a PushableCollectorRegistry which can collect prometheus metrics and push
them into an url

Planned to be used with https://github.com/zapier/prom-aggregation-gateway but
should work with https://github.com/prometheus/pushgateway

To use it

```ocaml
let pushableRegistry = PushableCollectorRegistry.create "http://localhost/metrics/job/ligo_compiler" in 
  let m = Counter.v ~registry:(pushableRegistry.collectorRegistry) ~help:"Test \\counter:\n1" "tests" in
  Counter.inc m 1.0;
  PushableCollectorRegistry.push pushableRegistry
```

After push, every registered metrics are no more usable for example

```ocaml
let pushableRegistry = PushableCollectorRegistry.create "http://localhost/metrics/job/ligo_compiler" in 
  let m = Counter.v ~registry:(pushableRegistry.collectorRegistry) ~help:"Test \\counter:\n1" "tests" in
  Counter.inc m 1.0;
  let _ = PushableCollectorRegistry.push pushableRegistry in 
  (* Instructions below will not affect the registry *)
  Counter.inc m 2.0;
  (* Push here will pus empty metrics *)
  PushableCollectorRegistry.push pushableRegistry;
```
