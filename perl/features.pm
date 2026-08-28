# BluefinTecsEcr SDK feature factory

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/feature/base_feature.pm"));
require(Cwd::abs_path("$__dir/feature/audit_feature.pm"));
require(Cwd::abs_path("$__dir/feature/clienttrack_feature.pm"));
require(Cwd::abs_path("$__dir/feature/idempotency_feature.pm"));
require(Cwd::abs_path("$__dir/feature/log_feature.pm"));
require(Cwd::abs_path("$__dir/feature/metrics_feature.pm"));
require(Cwd::abs_path("$__dir/feature/paging_feature.pm"));
require(Cwd::abs_path("$__dir/feature/ratelimit_feature.pm"));
require(Cwd::abs_path("$__dir/feature/retry_feature.pm"));
require(Cwd::abs_path("$__dir/feature/telemetry_feature.pm"));
require(Cwd::abs_path("$__dir/feature/test_feature.pm"));
require(Cwd::abs_path("$__dir/feature/timeout_feature.pm"));

package BluefinTecsEcrFeatures;

sub make_feature {
  my ($name) = @_;
  $name = '' unless defined $name;
  return BluefinTecsEcrBaseFeature->new if 'base' eq $name;
  return BluefinTecsEcrAuditFeature->new if 'audit' eq $name;
  return BluefinTecsEcrClienttrackFeature->new if 'clienttrack' eq $name;
  return BluefinTecsEcrIdempotencyFeature->new if 'idempotency' eq $name;
  return BluefinTecsEcrLogFeature->new if 'log' eq $name;
  return BluefinTecsEcrMetricsFeature->new if 'metrics' eq $name;
  return BluefinTecsEcrPagingFeature->new if 'paging' eq $name;
  return BluefinTecsEcrRatelimitFeature->new if 'ratelimit' eq $name;
  return BluefinTecsEcrRetryFeature->new if 'retry' eq $name;
  return BluefinTecsEcrTelemetryFeature->new if 'telemetry' eq $name;
  return BluefinTecsEcrTestFeature->new if 'test' eq $name;
  return BluefinTecsEcrTimeoutFeature->new if 'timeout' eq $name;
  return BluefinTecsEcrBaseFeature->new;
}

1;
