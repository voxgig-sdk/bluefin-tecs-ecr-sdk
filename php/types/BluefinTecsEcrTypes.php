<?php
declare(strict_types=1);

// Typed models for the BluefinTecsEcr SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** EcrApi entity data model. */
class EcrApi
{
    public string $amount;
    public ?string $authorization_number = null;
    public string $card_number;
    public string $currency;
    public ?string $cvc2 = null;
    public ?string $desired_currency = null;
    public ?string $ecr_data = null;
    public ?string $language = null;
    public ?string $message_type = null;
    public ?string $password = null;
    public ?string $payment_reason = null;
    public ?array $payment_reasonAsByte = null;
    public ?string $personal_id = null;
    public ?string $receipt_layout = null;
    public ?string $receipt_number = null;
    public string $terminal_number;
    public string $transaction_date_time;
    public string $transaction_id;
    public ?string $transaction_origin_identifier = null;
    public ?string $transaction_origin_indicator = null;
    public ?string $transaction_place = null;
    public ?string $transaction_source_id = null;
}

/** Request payload for EcrApi#load. */
class EcrApiLoadMatch
{
    public ?string $amount = null;
    public ?string $authorization_number = null;
    public ?string $card_number = null;
    public ?string $currency = null;
    public ?string $cvc2 = null;
    public ?string $desired_currency = null;
    public ?string $ecr_data = null;
    public ?string $language = null;
    public ?string $message_type = null;
    public ?string $password = null;
    public ?string $payment_reason = null;
    public ?array $payment_reasonAsByte = null;
    public ?string $personal_id = null;
    public ?string $receipt_layout = null;
    public ?string $receipt_number = null;
    public ?string $terminal_number = null;
    public ?string $transaction_date_time = null;
    public ?string $transaction_id = null;
    public ?string $transaction_origin_identifier = null;
    public ?string $transaction_origin_indicator = null;
    public ?string $transaction_place = null;
    public ?string $transaction_source_id = null;
}

/** Request payload for EcrApi#create. */
class EcrApiCreateData
{
    public string $amount;
    public ?string $authorization_number = null;
    public string $card_number;
    public string $currency;
    public ?string $cvc2 = null;
    public ?string $desired_currency = null;
    public ?string $ecr_data = null;
    public ?string $language = null;
    public ?string $message_type = null;
    public ?string $password = null;
    public ?string $payment_reason = null;
    public ?array $payment_reasonAsByte = null;
    public ?string $personal_id = null;
    public ?string $receipt_layout = null;
    public ?string $receipt_number = null;
    public string $terminal_number;
    public string $transaction_date_time;
    public string $transaction_id;
    public ?string $transaction_origin_identifier = null;
    public ?string $transaction_origin_indicator = null;
    public ?string $transaction_place = null;
    public ?string $transaction_source_id = null;
}

