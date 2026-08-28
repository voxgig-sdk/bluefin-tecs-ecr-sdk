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
                .{ "transport", h.vstr("none") },
            }) },
            .{ "clienttrack", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "clientVersion", h.vstr("0.0.1") },
                }) },
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
                .{ "transport", h.vstr("none") },
            }) },
            .{ "log", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(true) },
                }) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "metrics", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
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
                .{ "transport", h.vstr("none") },
            }) },
            .{ "ratelimit", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "burst", h.vnum(5) },
                    .{ "rate", h.vnum(5) },
                }) },
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
                .{ "transport", h.vstr("wrap") },
            }) },
            .{ "telemetry", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "transport", h.vstr("none") },
            }) },
            .{ "test", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                }) },
                .{ "transport", h.vstr("base") },
            }) },
            .{ "timeout", h.jo(&.{
                .{ "options", h.jo(&.{
                    .{ "active", h.vbool(false) },
                    .{ "ms", h.vnum(30000) },
                }) },
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
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Numeric Transaction Amount.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("authorization_number") },
                        .{ "short", h.vstr("For Gratuity (msg type 0009): the authorization number of the original transaction.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("card_number") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("currency") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\").") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("cvc2") },
                        .{ "short", h.vstr("Card Verification Code.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("desired_currency") },
                        .{ "short", h.vstr("ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\").") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("ecr_data") },
                        .{ "short", h.vstr("ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("language") },
                        .{ "short", h.vstr("ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\").") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("message_type") },
                        .{ "short", h.vstr("Message type code.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("password") },
                        .{ "short", h.vstr("Password - currently not used (filled with spaces).") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("payment_reason") },
                        .{ "short", h.vstr("Payment reason (e.g., \"Taxi journey\").") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("payment_reasonAsByte") },
                        .{ "short", h.vstr("Payment reason represented as a byte array.") },
                        .{ "type", h.vstr("`$ARRAY`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("personal_id") },
                        .{ "short", h.vstr("Identification of the current user of the ECR or Terminal.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("receipt_layout") },
                        .{ "short", h.vstr("Receipt layout identifier.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("receipt_number") },
                        .{ "short", h.vstr("Receipt number.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("terminal_number") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Terminal number provided by TECS.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_date_time") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Transaction date and time (format: yyyymmddhhmmss).") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_id") },
                        .{ "req", h.vbool(true) },
                        .{ "short", h.vstr("Unique transaction identifier.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_origin_identifier") },
                        .{ "short", h.vstr("Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_origin_indicator") },
                        .{ "short", h.vstr("Transaction origin indicator: - 0 = Request for card data on PIN PAD.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_place") },
                        .{ "short", h.vstr("The transaction place; the first 5 characters should contain a formatted zip code.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                    h.jo(&.{
                        .{ "name", h.vstr("transaction_source_id") },
                        .{ "short", h.vstr("Identification number of the authorization source.") },
                        .{ "type", h.vstr("`$STRING`") },
                    }),
                }) },
                .{ "name", h.vstr("ecr_api") },
                .{ "op", h.jo(&.{
                    .{ "create", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("create") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("POST") },
                                .{ "orig", h.vstr("/makeTransaction") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("makeTransaction"),
                                }) },
                                .{ "select", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
                            }),
                        }) },
                    }) },
                    .{ "load", h.jo(&.{
                        .{ "input", h.vstr("data") },
                        .{ "name", h.vstr("load") },
                        .{ "points", h.ja(&.{
                            h.jo(&.{
                                .{ "args", h.omap() },
                                .{ "kind", h.vstr("http") },
                                .{ "method", h.vstr("GET") },
                                .{ "orig", h.vstr("/version") },
                                .{ "parts", h.ja(&.{
                                    h.vstr("version"),
                                }) },
                                .{ "select", h.omap() },
                                .{ "transform", h.jo(&.{
                                    .{ "req", h.vstr("`reqdata`") },
                                    .{ "res", h.vstr("`body`") },
                                }) },
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
