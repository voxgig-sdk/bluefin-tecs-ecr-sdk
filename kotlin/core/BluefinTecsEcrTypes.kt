package voxgig.bluefintecsecrsdk.core

// Typed reference models for the BluefinTecsEcr SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These types are documentation/DX reference shapes ONLY. The SDK ops take and
// return the loose object model (MutableMap<String, Any?> / Any?) at runtime,
// so these types are not wired into the op signatures — use them to describe a
// payload before converting it to a map. Every component is a nullable type, so
// an optional (req:false) key needs no distinct rendering.

@Suppress("unused")
object BluefinTecsEcrTypes {

  data class EcrApi(val amount: String?, val authorization_number: String?, val card_number: String?, val currency: String?, val cvc2: String?, val desired_currency: String?, val ecr_data: String?, val language: String?, val message_type: String?, val password: String?, val payment_reason: String?, val payment_reason_as_byte: List<Any?>?, val personal_id: String?, val receipt_layout: String?, val receipt_number: String?, val terminal_number: String?, val transaction_date_time: String?, val transaction_id: String?, val transaction_origin_identifier: String?, val transaction_origin_indicator: String?, val transaction_place: String?, val transaction_source_id: String?)

  data class EcrApiLoadMatch(val amount: String?, val authorization_number: String?, val card_number: String?, val currency: String?, val cvc2: String?, val desired_currency: String?, val ecr_data: String?, val language: String?, val message_type: String?, val password: String?, val payment_reason: String?, val payment_reason_as_byte: List<Any?>?, val personal_id: String?, val receipt_layout: String?, val receipt_number: String?, val terminal_number: String?, val transaction_date_time: String?, val transaction_id: String?, val transaction_origin_identifier: String?, val transaction_origin_indicator: String?, val transaction_place: String?, val transaction_source_id: String?)

  data class EcrApiCreateData(val amount: String?, val authorization_number: String?, val card_number: String?, val currency: String?, val cvc2: String?, val desired_currency: String?, val ecr_data: String?, val language: String?, val message_type: String?, val password: String?, val payment_reason: String?, val payment_reason_as_byte: List<Any?>?, val personal_id: String?, val receipt_layout: String?, val receipt_number: String?, val terminal_number: String?, val transaction_date_time: String?, val transaction_id: String?, val transaction_origin_identifier: String?, val transaction_origin_indicator: String?, val transaction_place: String?, val transaction_source_id: String?)

}
