// Typed models for the BluefinTecsEcr SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return the
// `Value` enum), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support.
#![allow(dead_code, non_snake_case, unused_imports)]

use crate::utility::voxgigstruct::Value;

/// EcrApi is the typed data model for the ecr_api entity.
#[derive(Debug, Clone)]
pub struct EcrApi {
    pub amount: String,
    pub authorization_number: Option<String>,
    pub card_number: String,
    pub currency: String,
    pub cvc2: Option<String>,
    pub desired_currency: Option<String>,
    pub ecr_data: Option<String>,
    pub language: Option<String>,
    pub message_type: Option<String>,
    pub password: Option<String>,
    pub payment_reason: Option<String>,
    pub payment_reason_as_byte: Option<Vec<Value>>,
    pub personal_id: Option<String>,
    pub receipt_layout: Option<String>,
    pub receipt_number: Option<String>,
    pub terminal_number: String,
    pub transaction_date_time: String,
    pub transaction_id: String,
    pub transaction_origin_identifier: Option<String>,
    pub transaction_origin_indicator: Option<String>,
    pub transaction_place: Option<String>,
    pub transaction_source_id: Option<String>,
}

/// EcrApiLoadMatch is the typed request payload for EcrApi.load.
#[derive(Debug, Clone)]
pub struct EcrApiLoadMatch {
    pub amount: Option<String>,
    pub authorization_number: Option<String>,
    pub card_number: Option<String>,
    pub currency: Option<String>,
    pub cvc2: Option<String>,
    pub desired_currency: Option<String>,
    pub ecr_data: Option<String>,
    pub language: Option<String>,
    pub message_type: Option<String>,
    pub password: Option<String>,
    pub payment_reason: Option<String>,
    pub payment_reason_as_byte: Option<Vec<Value>>,
    pub personal_id: Option<String>,
    pub receipt_layout: Option<String>,
    pub receipt_number: Option<String>,
    pub terminal_number: Option<String>,
    pub transaction_date_time: Option<String>,
    pub transaction_id: Option<String>,
    pub transaction_origin_identifier: Option<String>,
    pub transaction_origin_indicator: Option<String>,
    pub transaction_place: Option<String>,
    pub transaction_source_id: Option<String>,
}

/// EcrApiCreateData is the typed request payload for EcrApi.create.
#[derive(Debug, Clone)]
pub struct EcrApiCreateData {
    pub amount: String,
    pub authorization_number: Option<String>,
    pub card_number: String,
    pub currency: String,
    pub cvc2: Option<String>,
    pub desired_currency: Option<String>,
    pub ecr_data: Option<String>,
    pub language: Option<String>,
    pub message_type: Option<String>,
    pub password: Option<String>,
    pub payment_reason: Option<String>,
    pub payment_reason_as_byte: Option<Vec<Value>>,
    pub personal_id: Option<String>,
    pub receipt_layout: Option<String>,
    pub receipt_number: Option<String>,
    pub terminal_number: String,
    pub transaction_date_time: String,
    pub transaction_id: String,
    pub transaction_origin_identifier: Option<String>,
    pub transaction_origin_indicator: Option<String>,
    pub transaction_place: Option<String>,
    pub transaction_source_id: Option<String>,
}

