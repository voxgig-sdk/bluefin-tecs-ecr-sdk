package voxgig.bluefintecsecrsdk.core

// Typed reference models for the BluefinTecsEcr SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These case classes are documentation/DX reference shapes ONLY. The SDK ops
// take and return the loose object model (java.util.Map[String, Object] /
// Object) at runtime, so these types are not wired into the op signatures —
// use them to describe a payload before converting it to a map. Every
// component is a boxed (nullable) type, so an optional (req:false) key needs
// no distinct rendering.

object BluefinTecsEcrTypes {

  final case class EcrApi(amount: String, authorization_number: String, card_number: String, currency: String, cvc2: String, desired_currency: String, ecr_data: String, language: String, message_type: String, password: String, payment_reason: String, payment_reasonAsByte: java.util.List[Object], personal_id: String, receipt_layout: String, receipt_number: String, terminal_number: String, transaction_date_time: String, transaction_id: String, transaction_origin_identifier: String, transaction_origin_indicator: String, transaction_place: String, transaction_source_id: String)

  final case class EcrApiLoadMatch(amount: String, authorization_number: String, card_number: String, currency: String, cvc2: String, desired_currency: String, ecr_data: String, language: String, message_type: String, password: String, payment_reason: String, payment_reasonAsByte: java.util.List[Object], personal_id: String, receipt_layout: String, receipt_number: String, terminal_number: String, transaction_date_time: String, transaction_id: String, transaction_origin_identifier: String, transaction_origin_indicator: String, transaction_place: String, transaction_source_id: String)

  final case class EcrApiCreateData(amount: String, authorization_number: String, card_number: String, currency: String, cvc2: String, desired_currency: String, ecr_data: String, language: String, message_type: String, password: String, payment_reason: String, payment_reasonAsByte: java.util.List[Object], personal_id: String, receipt_layout: String, receipt_number: String, terminal_number: String, transaction_date_time: String, transaction_id: String, transaction_origin_identifier: String, transaction_origin_indicator: String, transaction_place: String, transaction_source_id: String)

}
