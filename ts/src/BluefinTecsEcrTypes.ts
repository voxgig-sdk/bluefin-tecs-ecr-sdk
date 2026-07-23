// Typed models for the BluefinTecsEcr SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface EcrApi {
  amount: string
  authorization_number?: string
  card_number: string
  currency: string
  cvc2?: string
  desired_currency?: string
  ecr_data?: string
  language?: string
  message_type?: string
  password?: string
  payment_reason?: string
  payment_reason_as_byte?: any[]
  personal_id?: string
  receipt_layout?: string
  receipt_number?: string
  terminal_number: string
  transaction_date_time: string
  transaction_id: string
  transaction_origin_identifier?: string
  transaction_origin_indicator?: string
  transaction_place?: string
  transaction_source_id?: string
}

export interface EcrApiLoadMatch {
  amount?: string
  authorization_number?: string
  card_number?: string
  currency?: string
  cvc2?: string
  desired_currency?: string
  ecr_data?: string
  language?: string
  message_type?: string
  password?: string
  payment_reason?: string
  payment_reason_as_byte?: any[]
  personal_id?: string
  receipt_layout?: string
  receipt_number?: string
  terminal_number?: string
  transaction_date_time?: string
  transaction_id?: string
  transaction_origin_identifier?: string
  transaction_origin_indicator?: string
  transaction_place?: string
  transaction_source_id?: string
}

export interface EcrApiCreateData {
  amount: string
  authorization_number?: string
  card_number: string
  currency: string
  cvc2?: string
  desired_currency?: string
  ecr_data?: string
  language?: string
  message_type?: string
  password?: string
  payment_reason?: string
  payment_reason_as_byte?: any[]
  personal_id?: string
  receipt_layout?: string
  receipt_number?: string
  terminal_number: string
  transaction_date_time: string
  transaction_id: string
  transaction_origin_identifier?: string
  transaction_origin_indicator?: string
  transaction_place?: string
  transaction_source_id?: string
}

