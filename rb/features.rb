# BluefinTecsEcr SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/audit_feature'
require_relative 'feature/clienttrack_feature'
require_relative 'feature/idempotency_feature'
require_relative 'feature/log_feature'
require_relative 'feature/metrics_feature'
require_relative 'feature/paging_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/telemetry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module BluefinTecsEcrFeatures
  def self.make_feature(name)
    case name
    when "base"
      BluefinTecsEcrBaseFeature.new
    when "audit"
      BluefinTecsEcrAuditFeature.new
    when "clienttrack"
      BluefinTecsEcrClienttrackFeature.new
    when "idempotency"
      BluefinTecsEcrIdempotencyFeature.new
    when "log"
      BluefinTecsEcrLogFeature.new
    when "metrics"
      BluefinTecsEcrMetricsFeature.new
    when "paging"
      BluefinTecsEcrPagingFeature.new
    when "ratelimit"
      BluefinTecsEcrRatelimitFeature.new
    when "retry"
      BluefinTecsEcrRetryFeature.new
    when "telemetry"
      BluefinTecsEcrTelemetryFeature.new
    when "test"
      BluefinTecsEcrTestFeature.new
    when "timeout"
      BluefinTecsEcrTimeoutFeature.new
    else
      BluefinTecsEcrBaseFeature.new
    end
  end
end
