# BluefinTecsEcr SDK feature factory

defmodule BluefinTecsEcr.Features do
  def make_feature(name) do
    case name do
      "audit" -> BluefinTecsEcr.Feature.Audit.new()
      "clienttrack" -> BluefinTecsEcr.Feature.Clienttrack.new()
      "idempotency" -> BluefinTecsEcr.Feature.Idempotency.new()
      "log" -> BluefinTecsEcr.Feature.Log.new()
      "metrics" -> BluefinTecsEcr.Feature.Metrics.new()
      "paging" -> BluefinTecsEcr.Feature.Paging.new()
      "ratelimit" -> BluefinTecsEcr.Feature.Ratelimit.new()
      "retry" -> BluefinTecsEcr.Feature.Retry.new()
      "telemetry" -> BluefinTecsEcr.Feature.Telemetry.new()
      "test" -> BluefinTecsEcr.Feature.Test.new()
      "timeout" -> BluefinTecsEcr.Feature.Timeout.new()
      _ -> BluefinTecsEcr.Feature.new()
    end
  end
end
