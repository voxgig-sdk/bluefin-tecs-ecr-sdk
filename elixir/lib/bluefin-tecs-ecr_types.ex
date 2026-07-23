# Typed models for the BluefinTecsEcr SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels. The SDK carries data as string-keyed struct value
# nodes, so each alias is an open string-keyed map; the @typedoc member lists
# document the concrete shapes. Do not edit by hand.

defmodule BluefinTecsEcr.Types do
  @moduledoc """
  Documented shapes for the BluefinTecsEcr SDK entities and operation payloads.

  Every alias resolves to an open string-keyed map because the SDK carries
  data as string-keyed struct value nodes; consult each type's member list for
  the concrete field/param types.
  """

  @typedoc """
  EcrApi entity data model.

  Members:
    * `"amount"` — String.t() (required)
    * `"authorization_number"` — String.t() (optional)
    * `"card_number"` — String.t() (required)
    * `"currency"` — String.t() (required)
    * `"cvc2"` — String.t() (optional)
    * `"desired_currency"` — String.t() (optional)
    * `"ecr_data"` — String.t() (optional)
    * `"language"` — String.t() (optional)
    * `"message_type"` — String.t() (optional)
    * `"password"` — String.t() (optional)
    * `"payment_reason"` — String.t() (optional)
    * `"payment_reason_as_byte"` — list() (optional)
    * `"personal_id"` — String.t() (optional)
    * `"receipt_layout"` — String.t() (optional)
    * `"receipt_number"` — String.t() (optional)
    * `"terminal_number"` — String.t() (required)
    * `"transaction_date_time"` — String.t() (required)
    * `"transaction_id"` — String.t() (required)
    * `"transaction_origin_identifier"` — String.t() (optional)
    * `"transaction_origin_indicator"` — String.t() (optional)
    * `"transaction_place"` — String.t() (optional)
    * `"transaction_source_id"` — String.t() (optional)
  """
  @type ecr_api :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for EcrApi load.

  Members:
    * `"amount"` — String.t() (optional)
    * `"authorization_number"` — String.t() (optional)
    * `"card_number"` — String.t() (optional)
    * `"currency"` — String.t() (optional)
    * `"cvc2"` — String.t() (optional)
    * `"desired_currency"` — String.t() (optional)
    * `"ecr_data"` — String.t() (optional)
    * `"language"` — String.t() (optional)
    * `"message_type"` — String.t() (optional)
    * `"password"` — String.t() (optional)
    * `"payment_reason"` — String.t() (optional)
    * `"payment_reason_as_byte"` — list() (optional)
    * `"personal_id"` — String.t() (optional)
    * `"receipt_layout"` — String.t() (optional)
    * `"receipt_number"` — String.t() (optional)
    * `"terminal_number"` — String.t() (optional)
    * `"transaction_date_time"` — String.t() (optional)
    * `"transaction_id"` — String.t() (optional)
    * `"transaction_origin_identifier"` — String.t() (optional)
    * `"transaction_origin_indicator"` — String.t() (optional)
    * `"transaction_place"` — String.t() (optional)
    * `"transaction_source_id"` — String.t() (optional)
  """
  @type ecr_api_load_match :: %{optional(String.t()) => any()}

  @typedoc """
  Request payload for EcrApi create.

  Members:
    * `"amount"` — String.t() (required)
    * `"authorization_number"` — String.t() (optional)
    * `"card_number"` — String.t() (required)
    * `"currency"` — String.t() (required)
    * `"cvc2"` — String.t() (optional)
    * `"desired_currency"` — String.t() (optional)
    * `"ecr_data"` — String.t() (optional)
    * `"language"` — String.t() (optional)
    * `"message_type"` — String.t() (optional)
    * `"password"` — String.t() (optional)
    * `"payment_reason"` — String.t() (optional)
    * `"payment_reason_as_byte"` — list() (optional)
    * `"personal_id"` — String.t() (optional)
    * `"receipt_layout"` — String.t() (optional)
    * `"receipt_number"` — String.t() (optional)
    * `"terminal_number"` — String.t() (required)
    * `"transaction_date_time"` — String.t() (required)
    * `"transaction_id"` — String.t() (required)
    * `"transaction_origin_identifier"` — String.t() (optional)
    * `"transaction_origin_indicator"` — String.t() (optional)
    * `"transaction_place"` — String.t() (optional)
    * `"transaction_source_id"` — String.t() (optional)
  """
  @type ecr_api_create_data :: %{optional(String.t()) => any()}

end
