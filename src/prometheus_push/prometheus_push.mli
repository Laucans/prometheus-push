module PushableCollectorRegistry :
  sig
    type t = {
      url : Uri.t;
      mutable collectorRegistry : Prometheus.CollectorRegistry.t;
    }
    val create : string -> t
    val push : t -> (string * string, string * string) result Lwt.t
  end
