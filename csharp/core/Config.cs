// BluefinTecsEcr SDK - generated model configuration and feature
// factory. GENERATED from the API model - do not edit by hand.

namespace BluefinTecsEcrSdk;

public static class SdkConfig
{
    public static Dictionary<string, object?> MakeConfig()
    {
        return new Dictionary<string, object?>
        {
            ["main"] = new Dictionary<string, object?>
            {
                ["name"] = "BluefinTecsEcr",
                ["slug"] = "bluefin-tecs-ecr",
                ["version"] = "0.1.1",
                ["target"] = "csharp",
            },
            ["feature"] = new Dictionary<string, object?>
            {
                ["audit"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["actor"] = "anonymous",
                        ["max"] = 1000,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["sink"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["clienttrack"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["clientVersion"] = "0.0.1",
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["clientName"] = "`$STRING`",
                        ["clientVersion"] = "`$STRING`",
                        ["headers"] = "`$MAP`",
                        ["idgen"] = "`$FUNCTION`",
                        ["sessionId"] = "`$STRING`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["debug"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["max"] = 100,
                        ["redact"] = new List<object?>
                        {
                            "authorization",
                            "cookie",
                            "set-cookie",
                            "api-key",
                            "apikey",
                            "x-api-key",
                            "idempotency-key",
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["onEntry"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["idempotency"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["header"] = "Idempotency-Key",
                        ["methods"] = new List<object?>
                        {
                            "POST",
                            "PUT",
                            "PATCH",
                            "DELETE",
                        },
                        ["ops"] = new List<object?>
                        {
                            "create",
                            "update",
                            "remove",
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["keygen"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["log"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = true,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["level"] = "`$STRING`",
                        ["logger"] = "`$ANY`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["metrics"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["paging"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["afterVar"] = "after",
                        ["cursorParam"] = "cursor",
                        ["firstVar"] = "first",
                        ["limitParam"] = "limit",
                        ["pageParam"] = "page",
                        ["startPage"] = 1,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["limit"] = "`$NUMBER`",
                        ["ops"] = "`$LIST`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["ratelimit"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["burst"] = 5,
                        ["rate"] = 5,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["now"] = "`$FUNCTION`",
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["retry"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["factor"] = 2,
                        ["maxDelay"] = 2000,
                        ["minDelay"] = 50,
                        ["retries"] = 2,
                        ["statuses"] = new List<object?>
                        {
                            408,
                            425,
                            429,
                            500,
                            502,
                            503,
                            504,
                        },
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["jitter"] = "`$BOOLEAN`",
                        ["sleep"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
                ["telemetry"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["exporter"] = "`$FUNCTION`",
                        ["headers"] = "`$MAP`",
                        ["idgen"] = "`$FUNCTION`",
                        ["now"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "none",
                },
                ["test"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["entity"] = "`$MAP`",
                        ["net"] = "`$MAP`",
                    },
                    ["strict"] = false,
                    ["transport"] = "base",
                },
                ["timeout"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                        ["ms"] = 30000,
                    },
                    ["optspec"] = new Dictionary<string, object?>
                    {
                        ["clearTimer"] = "`$FUNCTION`",
                        ["setTimer"] = "`$FUNCTION`",
                    },
                    ["strict"] = false,
                    ["transport"] = "wrap",
                },
            },
            ["options"] = new Dictionary<string, object?>
            {
                ["base"] = "https://test.tecs.at/tecsclientrest-auth",
                ["auth"] = new Dictionary<string, object?>
                {
                    ["prefix"] = "Bearer",
                },
                ["headers"] = new Dictionary<string, object?>
                {
                    ["content-type"] = "application/json",
                },
                ["entity"] = new Dictionary<string, object?>
                {
                    ["ecr_api"] = new Dictionary<string, object?>(),
                },
            },
            ["entity"] = new Dictionary<string, object?>
            {
                ["ecr_api"] = new Dictionary<string, object?>
                {
                    ["fields"] = new List<object?>
                    {
                        new Dictionary<string, object?>
                        {
                            ["name"] = "amount",
                            ["title"] = "Amount",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Numeric Transaction Amount.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "authorization_number",
                            ["title"] = "Authorization Number",
                            ["type"] = "`$STRING`",
                            ["short"] = "For Gratuity (msg type 0009): the authorization number of the original transaction.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "card_number",
                            ["title"] = "Card Number",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "currency",
                            ["title"] = "Currency",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\").",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "cvc2",
                            ["title"] = "Cvc2",
                            ["type"] = "`$STRING`",
                            ["short"] = "Card Verification Code.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "desired_currency",
                            ["title"] = "Desired Currency",
                            ["type"] = "`$STRING`",
                            ["short"] = "ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\").",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "ecr_data",
                            ["title"] = "Ecr Data",
                            ["type"] = "`$STRING`",
                            ["short"] = "ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "language",
                            ["title"] = "Language",
                            ["type"] = "`$STRING`",
                            ["short"] = "ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\").",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "message_type",
                            ["title"] = "Message Type",
                            ["type"] = "`$STRING`",
                            ["short"] = "Message type code.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "password",
                            ["title"] = "Password",
                            ["type"] = "`$STRING`",
                            ["short"] = "Password - currently not used (filled with spaces).",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "payment_reason",
                            ["title"] = "Payment Reason",
                            ["type"] = "`$STRING`",
                            ["short"] = "Payment reason (e.g., \"Taxi journey\").",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "payment_reasonAsByte",
                            ["title"] = "Payment Reason As Byte",
                            ["type"] = "`$ARRAY`",
                            ["short"] = "Payment reason represented as a byte array.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "personal_id",
                            ["title"] = "Personal Id",
                            ["type"] = "`$STRING`",
                            ["short"] = "Identification of the current user of the ECR or Terminal.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "receipt_layout",
                            ["title"] = "Receipt Layout",
                            ["type"] = "`$STRING`",
                            ["short"] = "Receipt layout identifier.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "receipt_number",
                            ["title"] = "Receipt Number",
                            ["type"] = "`$STRING`",
                            ["short"] = "Receipt number.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "terminal_number",
                            ["title"] = "Terminal Number",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Terminal number provided by TECS.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "transaction_date_time",
                            ["title"] = "Transaction Date Time",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Transaction date and time (format: yyyymmddhhmmss).",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "transaction_id",
                            ["title"] = "Transaction Id",
                            ["type"] = "`$STRING`",
                            ["req"] = true,
                            ["short"] = "Unique transaction identifier.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "transaction_origin_identifier",
                            ["title"] = "Transaction Origin Identifier",
                            ["type"] = "`$STRING`",
                            ["short"] = "Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "transaction_origin_indicator",
                            ["title"] = "Transaction Origin Indicator",
                            ["type"] = "`$STRING`",
                            ["short"] = "Transaction origin indicator: - 0 = Request for card data on PIN PAD.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "transaction_place",
                            ["title"] = "Transaction Place",
                            ["type"] = "`$STRING`",
                            ["short"] = "The transaction place; the first 5 characters should contain a formatted zip code.",
                        },
                        new Dictionary<string, object?>
                        {
                            ["name"] = "transaction_source_id",
                            ["title"] = "Transaction Source Id",
                            ["type"] = "`$STRING`",
                            ["short"] = "Identification number of the authorization source.",
                        },
                    },
                    ["name"] = "ecr_api",
                    ["op"] = new Dictionary<string, object?>
                    {
                        ["create"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "create",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/makeTransaction",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "makeTransaction",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "makeTransaction",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                            },
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/version",
                                    ["segments"] = new List<object?>
                                    {
                                        new Dictionary<string, object?>
                                        {
                                            ["lit"] = "version",
                                        },
                                    },
                                    ["parts"] = new List<object?>
                                    {
                                        "version",
                                    },
                                    ["rename"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["select"] = new Dictionary<string, object?>(),
                                },
                            },
                        },
                    },
                    ["relations"] = new Dictionary<string, object?>
                    {
                        ["ancestors"] = new List<object?>(),
                    },
                },
            },
        };
    }

    private static readonly Lazy<Dictionary<string, object?>> SharedConfigVal =
        new(MakeConfig);

    // The process-wide config, built once on first use.
    //
    // The returned dictionary is SHARED: treat it as read-only. Callers that
    // need to mutate should use MakeConfig, which always returns a fresh copy.
    public static Dictionary<string, object?> SharedConfig()
    {
        return SharedConfigVal.Value;
    }

    public static List<object?> FeaturePlugins(string name)
    {
        switch (name)
        {
            default:
                return new List<object?>();
        }
    }

    public static Feature.BaseFeature MakeFeature(string name)
    {
        switch (name)
        {
            case "audit":
                return new Feature.AuditFeature();
            case "clienttrack":
                return new Feature.ClienttrackFeature();
            case "debug":
                return new Feature.DebugFeature();
            case "idempotency":
                return new Feature.IdempotencyFeature();
            case "log":
                return new Feature.LogFeature();
            case "metrics":
                return new Feature.MetricsFeature();
            case "paging":
                return new Feature.PagingFeature();
            case "ratelimit":
                return new Feature.RatelimitFeature();
            case "retry":
                return new Feature.RetryFeature();
            case "telemetry":
                return new Feature.TelemetryFeature();
            case "test":
                return new Feature.TestFeature();
            case "timeout":
                return new Feature.TimeoutFeature();
            default:
                return new Feature.BaseFeature();
        }
    }
}
