open Prometheus
open Prometheus_push

let main =
  let pushableRegistry = PushableCollectorRegistry.create "http://localhost/metrics/job/ligo_compiler" in 
    let m = Counter.v ~registry:(pushableRegistry.collectorRegistry) ~help:"Test \\counter:\n1" "tests" in
    Counter.inc m 1.0;
    PushableCollectorRegistry.push pushableRegistry 
