// Typed reference models for the BluefinTecsEcr SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These records are documentation/DX reference shapes ONLY. The SDK ops take
// and return the loose object model (Dictionary<string, object?> / object?) at
// runtime, so these types are not wired into the op signatures — use them to
// describe a payload before converting it to a dictionary. Optional (req:false)
// keys are modelled as nullable properties.

namespace BluefinTecsEcrSdk.Types;

public record EcrApi
{
    public string amount { get; init; }
    public string? authorization_number { get; init; }
    public string card_number { get; init; }
    public string currency { get; init; }
    public string? cvc2 { get; init; }
    public string? desired_currency { get; init; }
    public string? ecr_data { get; init; }
    public string? language { get; init; }
    public string? message_type { get; init; }
    public string? password { get; init; }
    public string? payment_reason { get; init; }
    public List<object?>? payment_reason_as_byte { get; init; }
    public string? personal_id { get; init; }
    public string? receipt_layout { get; init; }
    public string? receipt_number { get; init; }
    public string terminal_number { get; init; }
    public string transaction_date_time { get; init; }
    public string transaction_id { get; init; }
    public string? transaction_origin_identifier { get; init; }
    public string? transaction_origin_indicator { get; init; }
    public string? transaction_place { get; init; }
    public string? transaction_source_id { get; init; }
}

public record EcrApiLoadMatch
{
    public string? amount { get; init; }
    public string? authorization_number { get; init; }
    public string? card_number { get; init; }
    public string? currency { get; init; }
    public string? cvc2 { get; init; }
    public string? desired_currency { get; init; }
    public string? ecr_data { get; init; }
    public string? language { get; init; }
    public string? message_type { get; init; }
    public string? password { get; init; }
    public string? payment_reason { get; init; }
    public List<object?>? payment_reason_as_byte { get; init; }
    public string? personal_id { get; init; }
    public string? receipt_layout { get; init; }
    public string? receipt_number { get; init; }
    public string? terminal_number { get; init; }
    public string? transaction_date_time { get; init; }
    public string? transaction_id { get; init; }
    public string? transaction_origin_identifier { get; init; }
    public string? transaction_origin_indicator { get; init; }
    public string? transaction_place { get; init; }
    public string? transaction_source_id { get; init; }
}

public record EcrApiCreateData
{
    public string amount { get; init; }
    public string? authorization_number { get; init; }
    public string card_number { get; init; }
    public string currency { get; init; }
    public string? cvc2 { get; init; }
    public string? desired_currency { get; init; }
    public string? ecr_data { get; init; }
    public string? language { get; init; }
    public string? message_type { get; init; }
    public string? password { get; init; }
    public string? payment_reason { get; init; }
    public List<object?>? payment_reason_as_byte { get; init; }
    public string? personal_id { get; init; }
    public string? receipt_layout { get; init; }
    public string? receipt_number { get; init; }
    public string terminal_number { get; init; }
    public string transaction_date_time { get; init; }
    public string transaction_id { get; init; }
    public string? transaction_origin_identifier { get; init; }
    public string? transaction_origin_indicator { get; init; }
    public string? transaction_place { get; init; }
    public string? transaction_source_id { get; init; }
}

