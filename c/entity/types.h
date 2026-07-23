// Typed models for the BluefinTecsEcr SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return
// `voxgig_value*`), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support. This header is standalone
// and is not #included by any generated .c.

#ifndef BLUEFINTECSECR_ENTITY_TYPES_H
#define BLUEFINTECSECR_ENTITY_TYPES_H

#include "sdk.h"

// EcrApi is the typed data model for the ecr_api entity.
typedef struct {
  char*amount;
  char*authorization_number;  // optional
  char*card_number;
  char*currency;
  char*cvc2;  // optional
  char*desired_currency;  // optional
  char*ecr_data;  // optional
  char*language;  // optional
  char*message_type;  // optional
  char*password;  // optional
  char*payment_reason;  // optional
  voxgig_value*payment_reason_as_byte;  // optional
  char*personal_id;  // optional
  char*receipt_layout;  // optional
  char*receipt_number;  // optional
  char*terminal_number;
  char*transaction_date_time;
  char*transaction_id;
  char*transaction_origin_identifier;  // optional
  char*transaction_origin_indicator;  // optional
  char*transaction_place;  // optional
  char*transaction_source_id;  // optional
} EcrApi;

// EcrApiLoadMatch is the typed request payload for EcrApi.load.
typedef struct {
  char*amount;  // optional
  char*authorization_number;  // optional
  char*card_number;  // optional
  char*currency;  // optional
  char*cvc2;  // optional
  char*desired_currency;  // optional
  char*ecr_data;  // optional
  char*language;  // optional
  char*message_type;  // optional
  char*password;  // optional
  char*payment_reason;  // optional
  voxgig_value*payment_reason_as_byte;  // optional
  char*personal_id;  // optional
  char*receipt_layout;  // optional
  char*receipt_number;  // optional
  char*terminal_number;  // optional
  char*transaction_date_time;  // optional
  char*transaction_id;  // optional
  char*transaction_origin_identifier;  // optional
  char*transaction_origin_indicator;  // optional
  char*transaction_place;  // optional
  char*transaction_source_id;  // optional
} EcrApiLoadMatch;

// EcrApiCreateData is the typed request payload for EcrApi.create.
typedef struct {
  char*amount;
  char*authorization_number;  // optional
  char*card_number;
  char*currency;
  char*cvc2;  // optional
  char*desired_currency;  // optional
  char*ecr_data;  // optional
  char*language;  // optional
  char*message_type;  // optional
  char*password;  // optional
  char*payment_reason;  // optional
  voxgig_value*payment_reason_as_byte;  // optional
  char*personal_id;  // optional
  char*receipt_layout;  // optional
  char*receipt_number;  // optional
  char*terminal_number;
  char*transaction_date_time;
  char*transaction_id;
  char*transaction_origin_identifier;  // optional
  char*transaction_origin_indicator;  // optional
  char*transaction_place;  // optional
  char*transaction_source_id;  // optional
} EcrApiCreateData;

#endif // BLUEFINTECSECR_ENTITY_TYPES_H
