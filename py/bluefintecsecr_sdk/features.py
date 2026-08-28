# BluefinTecsEcr SDK feature factory

from bluefintecsecr_sdk.feature.base_feature import BluefinTecsEcrBaseFeature
from bluefintecsecr_sdk.feature.audit_feature import BluefinTecsEcrAuditFeature
from bluefintecsecr_sdk.feature.clienttrack_feature import BluefinTecsEcrClienttrackFeature
from bluefintecsecr_sdk.feature.idempotency_feature import BluefinTecsEcrIdempotencyFeature
from bluefintecsecr_sdk.feature.log_feature import BluefinTecsEcrLogFeature
from bluefintecsecr_sdk.feature.metrics_feature import BluefinTecsEcrMetricsFeature
from bluefintecsecr_sdk.feature.paging_feature import BluefinTecsEcrPagingFeature
from bluefintecsecr_sdk.feature.ratelimit_feature import BluefinTecsEcrRatelimitFeature
from bluefintecsecr_sdk.feature.retry_feature import BluefinTecsEcrRetryFeature
from bluefintecsecr_sdk.feature.telemetry_feature import BluefinTecsEcrTelemetryFeature
from bluefintecsecr_sdk.feature.test_feature import BluefinTecsEcrTestFeature
from bluefintecsecr_sdk.feature.timeout_feature import BluefinTecsEcrTimeoutFeature


_FEATURES = {
    "base": lambda: BluefinTecsEcrBaseFeature(),
    "audit": lambda: BluefinTecsEcrAuditFeature(),
    "clienttrack": lambda: BluefinTecsEcrClienttrackFeature(),
    "idempotency": lambda: BluefinTecsEcrIdempotencyFeature(),
    "log": lambda: BluefinTecsEcrLogFeature(),
    "metrics": lambda: BluefinTecsEcrMetricsFeature(),
    "paging": lambda: BluefinTecsEcrPagingFeature(),
    "ratelimit": lambda: BluefinTecsEcrRatelimitFeature(),
    "retry": lambda: BluefinTecsEcrRetryFeature(),
    "telemetry": lambda: BluefinTecsEcrTelemetryFeature(),
    "test": lambda: BluefinTecsEcrTestFeature(),
    "timeout": lambda: BluefinTecsEcrTimeoutFeature(),
}


def _make_feature(name):
    factory = _FEATURES.get(name)
    if factory is not None:
        return factory()
    return _FEATURES["base"]()


# True when this SDK was generated with the named feature class - the
# constructor's tolerance for extend-carried features reads this (an
# active name with no generated class must not become a BaseFeature
# stray when an extend instance carries it).
def _has_feature(name):
    return name in _FEATURES
