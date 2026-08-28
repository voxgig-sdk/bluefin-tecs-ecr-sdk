<?php
declare(strict_types=1);

// BluefinTecsEcr SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/AuditFeature.php';
require_once __DIR__ . '/feature/ClienttrackFeature.php';
require_once __DIR__ . '/feature/IdempotencyFeature.php';
require_once __DIR__ . '/feature/LogFeature.php';
require_once __DIR__ . '/feature/MetricsFeature.php';
require_once __DIR__ . '/feature/PagingFeature.php';
require_once __DIR__ . '/feature/RatelimitFeature.php';
require_once __DIR__ . '/feature/RetryFeature.php';
require_once __DIR__ . '/feature/TelemetryFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';
require_once __DIR__ . '/feature/TimeoutFeature.php';


class BluefinTecsEcrFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new BluefinTecsEcrBaseFeature();
            case "audit":
                return new BluefinTecsEcrAuditFeature();
            case "clienttrack":
                return new BluefinTecsEcrClienttrackFeature();
            case "idempotency":
                return new BluefinTecsEcrIdempotencyFeature();
            case "log":
                return new BluefinTecsEcrLogFeature();
            case "metrics":
                return new BluefinTecsEcrMetricsFeature();
            case "paging":
                return new BluefinTecsEcrPagingFeature();
            case "ratelimit":
                return new BluefinTecsEcrRatelimitFeature();
            case "retry":
                return new BluefinTecsEcrRetryFeature();
            case "telemetry":
                return new BluefinTecsEcrTelemetryFeature();
            case "test":
                return new BluefinTecsEcrTestFeature();
            case "timeout":
                return new BluefinTecsEcrTimeoutFeature();
            default:
                return new BluefinTecsEcrBaseFeature();
        }
    }

    /**
     * Does a generated feature class back this name? False for a name only
     * an options extend instance can supply (the station adopt path) - the
     * constructor uses this to skip make_feature for such names instead of
     * adding a stray BaseFeature.
     */
    public static function has_feature(string $name): bool
    {
        switch ($name) {
            case "base":
            case "audit":
            case "clienttrack":
            case "idempotency":
            case "log":
            case "metrics":
            case "paging":
            case "ratelimit":
            case "retry":
            case "telemetry":
            case "test":
            case "timeout":
                return true;
            default:
                return false;
        }
    }
}
