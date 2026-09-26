// Generated API configuration (mirrors go/rust core/config).

const std = @import("std");
const h = @import("helpers.zig");
const types = @import("types.zig");
const Value = h.Value;
const Feature = types.Feature;

pub fn make_config() Value {
    return h.jo(&.{
        .{ "main", h.jo(&.{
            .{ "name", h.vstr("BluefinTecsEcr") },
            .{ "slug", h.vstr("bluefin-tecs-ecr") },
            .{ "version", h.vstr("0.1.1") },
            .{ "target", h.vstr("zig") },
        }) },
        .{ "feature", h.jo(&.{
            .{ "audit", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "actor", h.vstr("anonymous") },
                    .{ "max", h.vnum(1000) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "sink", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "clienttrack", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "clientVersion", h.vstr("0.0.1") },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "clientName", h.vstr("`$STRING`") },
                    .{ "clientVersion", h.vstr("`$STRING`") },
                    .{ "headers", h.vstr("`$MAP`") },
                    .{ "idgen", h.vstr("`$FUNCTION`") },
                    .{ "sessionId", h.vstr("`$STRING`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "debug", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "max", h.vnum(100) },
                    .{ "redact", h.ja(&.{
                        h.vstr("authorization"),
                        h.vstr("cookie"),
                        h.vstr("set-cookie"),
                        h.vstr("api-key"),
                        h.vstr("apikey"),
                        h.vstr("x-api-key"),
                        h.vstr("idempotency-key"),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "onEntry", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "idempotency", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "header", h.vstr("Idempotency-Key") },
                    .{ "methods", h.ja(&.{
                        h.vstr("POST"),
                        h.vstr("PUT"),
                        h.vstr("PATCH"),
                        h.vstr("DELETE"),
                    }) },
                    .{ "ops", h.ja(&.{
                        h.vstr("create"),
                        h.vstr("update"),
                        h.vstr("remove"),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "keygen", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "log", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(true) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "level", h.vstr("`$STRING`") },
                    .{ "logger", h.vstr("`$ANY`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "metrics", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "paging", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "afterVar", h.vstr("after") },
                    .{ "cursorParam", h.vstr("cursor") },
                    .{ "firstVar", h.vstr("first") },
                    .{ "limitParam", h.vstr("limit") },
                    .{ "pageParam", h.vstr("page") },
                    .{ "startPage", h.vnum(1) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "limit", h.vstr("`$NUMBER`") },
                    .{ "ops", h.vstr("`$LIST`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "ratelimit", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "burst", h.vnum(5) },
                    .{ "rate", h.vnum(5) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "now", h.vstr("`$FUNCTION`") },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "retry", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "factor", h.vnum(2) },
                    .{ "maxDelay", h.vnum(2000) },
                    .{ "minDelay", h.vnum(50) },
                    .{ "retries", h.vnum(2) },
                    .{ "statuses", h.ja(&.{
                        h.vnum(408),
                        h.vnum(425),
                        h.vnum(429),
                        h.vnum(500),
                        h.vnum(502),
                        h.vnum(503),
                        h.vnum(504),
                    }) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "jitter", h.vstr("`$BOOLEAN`") },
                    .{ "sleep", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "telemetry", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "exporter", h.vstr("`$FUNCTION`") },
                    .{ "headers", h.vstr("`$MAP`") },
                    .{ "idgen", h.vstr("`$FUNCTION`") },
                    .{ "now", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "test", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "entity", h.vstr("`$MAP`") },
                    .{ "net", h.vstr("`$MAP`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("base") },
            }) },
            .{ "timeout", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "ms", h.vnum(30000) },
                }) },
                .{ "optspec", h.jo(&.{
                    .{ "clearTimer", h.vstr("`$FUNCTION`") },
                    .{ "setTimer", h.vstr("`$FUNCTION`") },
                }) },
                .{ "strict", h.vbool(false) },
                .{ "transport", h.vstr("wrap") },
            }) },
        }) },
        .{ "options", h.jo(&.{
            .{ "base", h.vstr("https://test.tecs.at/tecsclientrest-auth") },
            .{ "auth", h.jo(&.{
                .{ "prefix", h.vstr("Bearer") },
            }) },
            .{ "headers", h.jo(&.{
                .{ "content-type", h.vstr("application/json") },
            }) },
            .{ "entity", h.jo(&.{
                .{ "ecr_api", h.omap() },
            }) },
        }) },
        .{ "entity", h.jo(&.{
            .{ "ecr_api", h.jo(&.{
                .{ "fields", h.ja(&.{
                    h.jo(&.{
                        .{ "name", h.vstr("amount") },
                        .{ "title", h.vstr("Amount") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Numeric Transaction Amount.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("authorization_number") },
                        .{ "title", h.vstr("Authorization Number") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("For Gratuity (msg type 0009): the authorization number of the original transaction.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("card_number") },
                        .{ "title", h.vstr("Card Number") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("currency") },
                        .{ "title", h.vstr("Currency") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\").") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("cvc2") },
                        .{ "title", h.vstr("Cvc2") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Card Verification Code.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("desired_currency") },
                        .{ "title", h.vstr("Desired Currency") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\").") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("ecr_data") },
                        .{ "title", h.vstr("Ecr Data") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("language") },
                        .{ "title", h.vstr("Language") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\").") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("message_type") },
                        .{ "title", h.vstr("Message Type") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Message type code.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("password") },
                        .{ "title", h.vstr("Password") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Password - currently not used (filled with spaces).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("payment_reason") },
                        .{ "title", h.vstr("Payment Reason") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Payment reason (e.g., \"Taxi journey\").") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("payment_reasonAsByte") },
                        .{ "title", h.vstr("Payment Reason As Byte") },
                        .{ "type", h.vstr("`$ARRAY`") },
                        .{ "short", h.vstr("Payment reason represented as a byte array.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("personal_id") },
                        .{ "title", h.vstr("Personal Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Identification of the current user of the ECR or Terminal.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("receipt_layout") },
                        .{ "title", h.vstr("Receipt Layout") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Receipt layout identifier.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("receipt_number") },
                        .{ "title", h.vstr("Receipt Number") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Receipt number.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("terminal_number") },
                        .{ "title", h.vstr("Terminal Number") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Terminal number provided by TECS.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_date_time") },
                        .{ "title", h.vstr("Transaction Date Time") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Transaction date and time (format: yyyymmddhhmmss).") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_id") },
                        .{ "title", h.vstr("Transaction Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Unique transaction identifier.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_origin_identifier") },
                        .{ "title", h.vstr("Transaction Origin Identifier") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_origin_indicator") },
                        .{ "title", h.vstr("Transaction Origin Indicator") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Transaction origin indicator: - 0 = Request for card data on PIN PAD.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_place") },
                        .{ "title", h.vstr("Transaction Place") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("The transaction place; the first 5 characters should contain a formatted zip code.") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_source_id") },
                        .{ "title", h.vstr("Transaction Source Id") },
                        .{ "type", h.vstr("`$STRING`") },
                        .{ "short", h.vstr("Identification number of the authorization source.") },
                    }),
                }) },
                .{ "name", h.vstr("ecr_api") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/makeTransaction") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("makeTransaction") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("makeTransaction"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/version") },
                                .{ "segments", h.ja(&.{
                                    h.jo(&.{
                                        .{ "lit", h.vstr("version") },
                                    }),
                                }) },
                                .{ "parts", h.ja(&.{
                                    h.vstr("version"),
                                }) },
                                .{ "rename", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                                .{ "args", h.omap() },
                                .{ "select", h.omap() },
                            }),
                        }) },
                    }) },
                }) },
                .{ "relations", h.jo(&.{
                    .{ "ancestors", h.olist() },
                }) },
            }) },
        }) },
    });
}

// SHARED CONFIG (sdkgen rung L2).
//
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client. Above the
// size threshold make_config re-parses the whole embedded JSON, so this is the
// difference between parsing the model once and once per client.
//
// Value nodes are arena-allocated and reference-stable, so the shared value is
// genuinely one structure, not a copy.
var shared_config_val: ?Value = null;

/// The process-wide config, built once on first use.
///
/// The returned Value SHARES its nodes: treat it as read-only. Callers that
/// need to mutate should use make_config, which always returns a fresh copy.
pub fn shared_config() Value {
    if (shared_config_val) |c| return c;
    const c = make_config();
    shared_config_val = c;
    return c;
}

pub fn make_feature(name: []const u8) Feature {
    if (std.mem.eql(u8, name, "audit")) return @import("../feature/audit.zig").AuditFeature.make();
    if (std.mem.eql(u8, name, "cache")) return @import("../feature/cache.zig").CacheFeature.make();
    if (std.mem.eql(u8, name, "clienttrack")) return @import("../feature/clienttrack.zig").ClienttrackFeature.make();
    if (std.mem.eql(u8, name, "cost")) return @import("../feature/cost.zig").CostFeature.make();
    if (std.mem.eql(u8, name, "debug")) return @import("../feature/debug.zig").DebugFeature.make();
    if (std.mem.eql(u8, name, "idempotency")) return @import("../feature/idempotency.zig").IdempotencyFeature.make();
    if (std.mem.eql(u8, name, "log")) return @import("../feature/log.zig").LogFeature.make();
    if (std.mem.eql(u8, name, "metrics")) return @import("../feature/metrics.zig").MetricsFeature.make();
    if (std.mem.eql(u8, name, "netsim")) return @import("../feature/netsim.zig").NetsimFeature.make();
    if (std.mem.eql(u8, name, "paging")) return @import("../feature/paging.zig").PagingFeature.make();
    if (std.mem.eql(u8, name, "proxy")) return @import("../feature/proxy.zig").ProxyFeature.make();
    if (std.mem.eql(u8, name, "ratelimit")) return @import("../feature/ratelimit.zig").RatelimitFeature.make();
    if (std.mem.eql(u8, name, "rbac")) return @import("../feature/rbac.zig").RbacFeature.make();
    if (std.mem.eql(u8, name, "retry")) return @import("../feature/retry.zig").RetryFeature.make();
    if (std.mem.eql(u8, name, "streaming")) return @import("../feature/streaming.zig").StreamingFeature.make();
    if (std.mem.eql(u8, name, "telemetry")) return @import("../feature/telemetry.zig").TelemetryFeature.make();
    if (std.mem.eql(u8, name, "test")) return @import("../feature/test.zig").TestFeature.make();
    if (std.mem.eql(u8, name, "timeout")) return @import("../feature/timeout.zig").TimeoutFeature.make();
    return @import("../feature/base.zig").BaseFeature.make();
}
