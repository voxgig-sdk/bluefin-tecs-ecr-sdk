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
            },
            ["feature"] = new Dictionary<string, object?>
            {
                ["test"] = new Dictionary<string, object?>
                {
                    ["options"] = new Dictionary<string, object?>
                    {
                        ["active"] = false,
                    },
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
                            ["active"] = true,
                            ["name"] = "amount",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 0,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "authorization_number",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 1,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "card_number",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 2,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "currency",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 3,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "cvc2",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 4,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "desired_currency",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 5,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "ecr_data",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 6,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "language",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 7,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "message_type",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 8,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "password",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 9,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "payment_reason",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 10,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "payment_reasonAsByte",
                            ["req"] = false,
                            ["type"] = "`$ARRAY`",
                            ["index$"] = 11,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "personal_id",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 12,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "receipt_layout",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 13,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "receipt_number",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 14,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "terminal_number",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 15,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "transaction_date_time",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 16,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "transaction_id",
                            ["req"] = true,
                            ["type"] = "`$STRING`",
                            ["index$"] = 17,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "transaction_origin_identifier",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 18,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "transaction_origin_indicator",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 19,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "transaction_place",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 20,
                        },
                        new Dictionary<string, object?>
                        {
                            ["active"] = true,
                            ["name"] = "transaction_source_id",
                            ["req"] = false,
                            ["type"] = "`$STRING`",
                            ["index$"] = 21,
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
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
                                    ["method"] = "POST",
                                    ["orig"] = "/makeTransaction",
                                    ["parts"] = new List<object?>
                                    {
                                        "makeTransaction",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                            },
                            ["key$"] = "create",
                        },
                        ["load"] = new Dictionary<string, object?>
                        {
                            ["input"] = "data",
                            ["name"] = "load",
                            ["points"] = new List<object?>
                            {
                                new Dictionary<string, object?>
                                {
                                    ["active"] = true,
                                    ["args"] = new Dictionary<string, object?>(),
                                    ["kind"] = "http",
                                    ["method"] = "GET",
                                    ["orig"] = "/version",
                                    ["parts"] = new List<object?>
                                    {
                                        "version",
                                    },
                                    ["select"] = new Dictionary<string, object?>(),
                                    ["transform"] = new Dictionary<string, object?>
                                    {
                                        ["req"] = "`reqdata`",
                                        ["res"] = "`body`",
                                    },
                                    ["index$"] = 0,
                                },
                            },
                            ["key$"] = "load",
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

    public static Feature.BaseFeature MakeFeature(string name)
    {
        switch (name)
        {
            case "test":
                return new Feature.TestFeature();
            default:
                return new Feature.BaseFeature();
        }
    }
}
