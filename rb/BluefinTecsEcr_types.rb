# frozen_string_literal: true

# Typed models for the BluefinTecsEcr SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# EcrApi entity data model.
#
# @!attribute [rw] amount
#   @return [String]
#
# @!attribute [rw] authorization_number
#   @return [String, nil]
#
# @!attribute [rw] card_number
#   @return [String]
#
# @!attribute [rw] currency
#   @return [String]
#
# @!attribute [rw] cvc2
#   @return [String, nil]
#
# @!attribute [rw] desired_currency
#   @return [String, nil]
#
# @!attribute [rw] ecr_data
#   @return [String, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] message_type
#   @return [String, nil]
#
# @!attribute [rw] password
#   @return [String, nil]
#
# @!attribute [rw] payment_reason
#   @return [String, nil]
#
# @!attribute [rw] payment_reason_as_byte
#   @return [Array, nil]
#
# @!attribute [rw] personal_id
#   @return [String, nil]
#
# @!attribute [rw] receipt_layout
#   @return [String, nil]
#
# @!attribute [rw] receipt_number
#   @return [String, nil]
#
# @!attribute [rw] terminal_number
#   @return [String]
#
# @!attribute [rw] transaction_date_time
#   @return [String]
#
# @!attribute [rw] transaction_id
#   @return [String]
#
# @!attribute [rw] transaction_origin_identifier
#   @return [String, nil]
#
# @!attribute [rw] transaction_origin_indicator
#   @return [String, nil]
#
# @!attribute [rw] transaction_place
#   @return [String, nil]
#
# @!attribute [rw] transaction_source_id
#   @return [String, nil]
EcrApi = Struct.new(
  :amount,
  :authorization_number,
  :card_number,
  :currency,
  :cvc2,
  :desired_currency,
  :ecr_data,
  :language,
  :message_type,
  :password,
  :payment_reason,
  :payment_reason_as_byte,
  :personal_id,
  :receipt_layout,
  :receipt_number,
  :terminal_number,
  :transaction_date_time,
  :transaction_id,
  :transaction_origin_identifier,
  :transaction_origin_indicator,
  :transaction_place,
  :transaction_source_id,
  keyword_init: true
)

# Request payload for EcrApi#load.
#
# @!attribute [rw] amount
#   @return [String, nil]
#
# @!attribute [rw] authorization_number
#   @return [String, nil]
#
# @!attribute [rw] card_number
#   @return [String, nil]
#
# @!attribute [rw] currency
#   @return [String, nil]
#
# @!attribute [rw] cvc2
#   @return [String, nil]
#
# @!attribute [rw] desired_currency
#   @return [String, nil]
#
# @!attribute [rw] ecr_data
#   @return [String, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] message_type
#   @return [String, nil]
#
# @!attribute [rw] password
#   @return [String, nil]
#
# @!attribute [rw] payment_reason
#   @return [String, nil]
#
# @!attribute [rw] payment_reason_as_byte
#   @return [Array, nil]
#
# @!attribute [rw] personal_id
#   @return [String, nil]
#
# @!attribute [rw] receipt_layout
#   @return [String, nil]
#
# @!attribute [rw] receipt_number
#   @return [String, nil]
#
# @!attribute [rw] terminal_number
#   @return [String, nil]
#
# @!attribute [rw] transaction_date_time
#   @return [String, nil]
#
# @!attribute [rw] transaction_id
#   @return [String, nil]
#
# @!attribute [rw] transaction_origin_identifier
#   @return [String, nil]
#
# @!attribute [rw] transaction_origin_indicator
#   @return [String, nil]
#
# @!attribute [rw] transaction_place
#   @return [String, nil]
#
# @!attribute [rw] transaction_source_id
#   @return [String, nil]
EcrApiLoadMatch = Struct.new(
  :amount,
  :authorization_number,
  :card_number,
  :currency,
  :cvc2,
  :desired_currency,
  :ecr_data,
  :language,
  :message_type,
  :password,
  :payment_reason,
  :payment_reason_as_byte,
  :personal_id,
  :receipt_layout,
  :receipt_number,
  :terminal_number,
  :transaction_date_time,
  :transaction_id,
  :transaction_origin_identifier,
  :transaction_origin_indicator,
  :transaction_place,
  :transaction_source_id,
  keyword_init: true
)

# Request payload for EcrApi#create.
#
# @!attribute [rw] amount
#   @return [String]
#
# @!attribute [rw] authorization_number
#   @return [String, nil]
#
# @!attribute [rw] card_number
#   @return [String]
#
# @!attribute [rw] currency
#   @return [String]
#
# @!attribute [rw] cvc2
#   @return [String, nil]
#
# @!attribute [rw] desired_currency
#   @return [String, nil]
#
# @!attribute [rw] ecr_data
#   @return [String, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] message_type
#   @return [String, nil]
#
# @!attribute [rw] password
#   @return [String, nil]
#
# @!attribute [rw] payment_reason
#   @return [String, nil]
#
# @!attribute [rw] payment_reason_as_byte
#   @return [Array, nil]
#
# @!attribute [rw] personal_id
#   @return [String, nil]
#
# @!attribute [rw] receipt_layout
#   @return [String, nil]
#
# @!attribute [rw] receipt_number
#   @return [String, nil]
#
# @!attribute [rw] terminal_number
#   @return [String]
#
# @!attribute [rw] transaction_date_time
#   @return [String]
#
# @!attribute [rw] transaction_id
#   @return [String]
#
# @!attribute [rw] transaction_origin_identifier
#   @return [String, nil]
#
# @!attribute [rw] transaction_origin_indicator
#   @return [String, nil]
#
# @!attribute [rw] transaction_place
#   @return [String, nil]
#
# @!attribute [rw] transaction_source_id
#   @return [String, nil]
EcrApiCreateData = Struct.new(
  :amount,
  :authorization_number,
  :card_number,
  :currency,
  :cvc2,
  :desired_currency,
  :ecr_data,
  :language,
  :message_type,
  :password,
  :payment_reason,
  :payment_reason_as_byte,
  :personal_id,
  :receipt_layout,
  :receipt_number,
  :terminal_number,
  :transaction_date_time,
  :transaction_id,
  :transaction_origin_identifier,
  :transaction_origin_indicator,
  :transaction_place,
  :transaction_source_id,
  keyword_init: true
)

