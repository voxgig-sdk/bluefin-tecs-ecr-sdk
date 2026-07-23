package voxgig.bluefintecsecrsdk.core;

// Typed reference models for the BluefinTecsEcr SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON). Do
// not edit by hand.
//
// These records are documentation/DX reference shapes ONLY. The SDK ops take
// and return the loose object model (Map<String, Object> / Object) at runtime,
// so these types are not wired into the op signatures — use them to describe a
// payload before converting it to a map. Every component is a boxed (nullable)
// type, so an optional (req:false) key needs no distinct rendering.

import java.util.List;
import java.util.Map;

public final class BluefinTecsEcrTypes {

  private BluefinTecsEcrTypes() {}

  public record EcrApi(String amount, String authorization_number, String card_number, String currency, String cvc2, String desired_currency, String ecr_data, String language, String message_type, String password, String payment_reason, List<Object> payment_reason_as_byte, String personal_id, String receipt_layout, String receipt_number, String terminal_number, String transaction_date_time, String transaction_id, String transaction_origin_identifier, String transaction_origin_indicator, String transaction_place, String transaction_source_id) {}

  public record EcrApiLoadMatch(String amount, String authorization_number, String card_number, String currency, String cvc2, String desired_currency, String ecr_data, String language, String message_type, String password, String payment_reason, List<Object> payment_reason_as_byte, String personal_id, String receipt_layout, String receipt_number, String terminal_number, String transaction_date_time, String transaction_id, String transaction_origin_identifier, String transaction_origin_indicator, String transaction_place, String transaction_source_id) {}

  public record EcrApiCreateData(String amount, String authorization_number, String card_number, String currency, String cvc2, String desired_currency, String ecr_data, String language, String message_type, String password, String payment_reason, List<Object> payment_reason_as_byte, String personal_id, String receipt_layout, String receipt_number, String terminal_number, String transaction_date_time, String transaction_id, String transaction_origin_identifier, String transaction_origin_indicator, String transaction_place, String transaction_source_id) {}

}
