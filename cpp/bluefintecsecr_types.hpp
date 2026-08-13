// Typed reference models for the BluefinTecsEcr SDK (C++).
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params. The C++ SDK runtime is Value-based, so these structs are
// DOCUMENTATION / convenience types only — the SDK neither includes nor
// requires this header. Array fields surface as std::vector<Value>, object
// fields as std::map<std::string, Value>, and any/null fields as sdk::Value.
// Optional (req:false) members are flagged with a trailing "// optional"
// comment. Do not edit by hand.

#ifndef SDK_BLUEFINTECSECR_TYPES_HPP
#define SDK_BLUEFINTECSECR_TYPES_HPP

#include <cstdint>
#include <map>
#include <string>
#include <vector>

#include "core/types.hpp"

namespace sdk {
namespace types {

struct EcrApi {
  std::string amount;
  std::string authorization_number;  // optional
  std::string card_number;
  std::string currency;
  std::string cvc2;  // optional
  std::string desired_currency;  // optional
  std::string ecr_data;  // optional
  std::string language;  // optional
  std::string message_type;  // optional
  std::string password;  // optional
  std::string payment_reason;  // optional
  std::vector<Value> payment_reasonAsByte;  // optional
  std::string personal_id;  // optional
  std::string receipt_layout;  // optional
  std::string receipt_number;  // optional
  std::string terminal_number;
  std::string transaction_date_time;
  std::string transaction_id;
  std::string transaction_origin_identifier;  // optional
  std::string transaction_origin_indicator;  // optional
  std::string transaction_place;  // optional
  std::string transaction_source_id;  // optional
};

struct EcrApiLoadMatch {
  std::string amount;  // optional
  std::string authorization_number;  // optional
  std::string card_number;  // optional
  std::string currency;  // optional
  std::string cvc2;  // optional
  std::string desired_currency;  // optional
  std::string ecr_data;  // optional
  std::string language;  // optional
  std::string message_type;  // optional
  std::string password;  // optional
  std::string payment_reason;  // optional
  std::vector<Value> payment_reasonAsByte;  // optional
  std::string personal_id;  // optional
  std::string receipt_layout;  // optional
  std::string receipt_number;  // optional
  std::string terminal_number;  // optional
  std::string transaction_date_time;  // optional
  std::string transaction_id;  // optional
  std::string transaction_origin_identifier;  // optional
  std::string transaction_origin_indicator;  // optional
  std::string transaction_place;  // optional
  std::string transaction_source_id;  // optional
};

struct EcrApiCreateData {
  std::string amount;
  std::string authorization_number;  // optional
  std::string card_number;
  std::string currency;
  std::string cvc2;  // optional
  std::string desired_currency;  // optional
  std::string ecr_data;  // optional
  std::string language;  // optional
  std::string message_type;  // optional
  std::string password;  // optional
  std::string payment_reason;  // optional
  std::vector<Value> payment_reasonAsByte;  // optional
  std::string personal_id;  // optional
  std::string receipt_layout;  // optional
  std::string receipt_number;  // optional
  std::string terminal_number;
  std::string transaction_date_time;
  std::string transaction_id;
  std::string transaction_origin_identifier;  // optional
  std::string transaction_origin_indicator;  // optional
  std::string transaction_place;  // optional
  std::string transaction_source_id;  // optional
};

} // namespace types
} // namespace sdk

#endif // SDK_BLUEFINTECSECR_TYPES_HPP
