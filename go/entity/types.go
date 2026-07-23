// Typed models for the BluefinTecsEcr SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import "encoding/json"

// EcrApi is the typed data model for the ecr_api entity.
type EcrApi struct {
	Amount string `json:"amount"`
	AuthorizationNumber *string `json:"authorization_number,omitempty"`
	CardNumber string `json:"card_number"`
	Currency string `json:"currency"`
	Cvc2 *string `json:"cvc2,omitempty"`
	DesiredCurrency *string `json:"desired_currency,omitempty"`
	EcrData *string `json:"ecr_data,omitempty"`
	Language *string `json:"language,omitempty"`
	MessageType *string `json:"message_type,omitempty"`
	Password *string `json:"password,omitempty"`
	PaymentReason *string `json:"payment_reason,omitempty"`
	PaymentReasonAsByte *[]any `json:"payment_reason_as_byte,omitempty"`
	PersonalId *string `json:"personal_id,omitempty"`
	ReceiptLayout *string `json:"receipt_layout,omitempty"`
	ReceiptNumber *string `json:"receipt_number,omitempty"`
	TerminalNumber string `json:"terminal_number"`
	TransactionDateTime string `json:"transaction_date_time"`
	TransactionId string `json:"transaction_id"`
	TransactionOriginIdentifier *string `json:"transaction_origin_identifier,omitempty"`
	TransactionOriginIndicator *string `json:"transaction_origin_indicator,omitempty"`
	TransactionPlace *string `json:"transaction_place,omitempty"`
	TransactionSourceId *string `json:"transaction_source_id,omitempty"`
}

// EcrApiLoadMatch is the typed request payload for EcrApi.LoadTyped.
type EcrApiLoadMatch struct {
	Amount *string `json:"amount,omitempty"`
	AuthorizationNumber *string `json:"authorization_number,omitempty"`
	CardNumber *string `json:"card_number,omitempty"`
	Currency *string `json:"currency,omitempty"`
	Cvc2 *string `json:"cvc2,omitempty"`
	DesiredCurrency *string `json:"desired_currency,omitempty"`
	EcrData *string `json:"ecr_data,omitempty"`
	Language *string `json:"language,omitempty"`
	MessageType *string `json:"message_type,omitempty"`
	Password *string `json:"password,omitempty"`
	PaymentReason *string `json:"payment_reason,omitempty"`
	PaymentReasonAsByte *[]any `json:"payment_reason_as_byte,omitempty"`
	PersonalId *string `json:"personal_id,omitempty"`
	ReceiptLayout *string `json:"receipt_layout,omitempty"`
	ReceiptNumber *string `json:"receipt_number,omitempty"`
	TerminalNumber *string `json:"terminal_number,omitempty"`
	TransactionDateTime *string `json:"transaction_date_time,omitempty"`
	TransactionId *string `json:"transaction_id,omitempty"`
	TransactionOriginIdentifier *string `json:"transaction_origin_identifier,omitempty"`
	TransactionOriginIndicator *string `json:"transaction_origin_indicator,omitempty"`
	TransactionPlace *string `json:"transaction_place,omitempty"`
	TransactionSourceId *string `json:"transaction_source_id,omitempty"`
}

// EcrApiCreateData is the typed request payload for EcrApi.CreateTyped.
type EcrApiCreateData struct {
	Amount string `json:"amount"`
	AuthorizationNumber *string `json:"authorization_number,omitempty"`
	CardNumber string `json:"card_number"`
	Currency string `json:"currency"`
	Cvc2 *string `json:"cvc2,omitempty"`
	DesiredCurrency *string `json:"desired_currency,omitempty"`
	EcrData *string `json:"ecr_data,omitempty"`
	Language *string `json:"language,omitempty"`
	MessageType *string `json:"message_type,omitempty"`
	Password *string `json:"password,omitempty"`
	PaymentReason *string `json:"payment_reason,omitempty"`
	PaymentReasonAsByte *[]any `json:"payment_reason_as_byte,omitempty"`
	PersonalId *string `json:"personal_id,omitempty"`
	ReceiptLayout *string `json:"receipt_layout,omitempty"`
	ReceiptNumber *string `json:"receipt_number,omitempty"`
	TerminalNumber string `json:"terminal_number"`
	TransactionDateTime string `json:"transaction_date_time"`
	TransactionId string `json:"transaction_id"`
	TransactionOriginIdentifier *string `json:"transaction_origin_identifier,omitempty"`
	TransactionOriginIndicator *string `json:"transaction_origin_indicator,omitempty"`
	TransactionPlace *string `json:"transaction_place,omitempty"`
	TransactionSourceId *string `json:"transaction_source_id,omitempty"`
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedFrom decodes a runtime value (a map[string]any produced by the op
// pipeline) into a typed model T via a JSON round-trip. On any error it
// returns the zero value of T; the op's own (value, error) tuple carries the
// real error.
func typedFrom[T any](v any) T {
	var out T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value ([]any of maps) into a typed
// slice []T via a JSON round-trip, for list ops.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
