// Typed models for the BluefinTecsEcr SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels (source of truth: @voxgig/apidef VALID_CANON).
// Do not edit by hand.
//
// The operation pipeline passes plain maps; these classes are the typed,
// convertible view: `BluefinTecsEcr.fromMap(ent.data())` / `model.toMap()`.

class EcrApi {
  /// STRING (required at the API)
  String? amount;
  /// STRING
  String? authorization_number;
  /// STRING (required at the API)
  String? card_number;
  /// STRING (required at the API)
  String? currency;
  /// STRING
  String? cvc2;
  /// STRING
  String? desired_currency;
  /// STRING
  String? ecr_data;
  /// STRING
  String? language;
  /// STRING
  String? message_type;
  /// STRING
  String? password;
  /// STRING
  String? payment_reason;
  /// ARRAY
  List<dynamic>? payment_reasonAsByte;
  /// STRING
  String? personal_id;
  /// STRING
  String? receipt_layout;
  /// STRING
  String? receipt_number;
  /// STRING (required at the API)
  String? terminal_number;
  /// STRING (required at the API)
  String? transaction_date_time;
  /// STRING (required at the API)
  String? transaction_id;
  /// STRING
  String? transaction_origin_identifier;
  /// STRING
  String? transaction_origin_indicator;
  /// STRING
  String? transaction_place;
  /// STRING
  String? transaction_source_id;

  EcrApi({
    this.amount,
    this.authorization_number,
    this.card_number,
    this.currency,
    this.cvc2,
    this.desired_currency,
    this.ecr_data,
    this.language,
    this.message_type,
    this.password,
    this.payment_reason,
    this.payment_reasonAsByte,
    this.personal_id,
    this.receipt_layout,
    this.receipt_number,
    this.terminal_number,
    this.transaction_date_time,
    this.transaction_id,
    this.transaction_origin_identifier,
    this.transaction_origin_indicator,
    this.transaction_place,
    this.transaction_source_id,
  });

  factory EcrApi.fromMap(Map<String, dynamic> m) => EcrApi(
        amount: m['amount'] is String ? m['amount'] : null,
        authorization_number: m['authorization_number'] is String ? m['authorization_number'] : null,
        card_number: m['card_number'] is String ? m['card_number'] : null,
        currency: m['currency'] is String ? m['currency'] : null,
        cvc2: m['cvc2'] is String ? m['cvc2'] : null,
        desired_currency: m['desired_currency'] is String ? m['desired_currency'] : null,
        ecr_data: m['ecr_data'] is String ? m['ecr_data'] : null,
        language: m['language'] is String ? m['language'] : null,
        message_type: m['message_type'] is String ? m['message_type'] : null,
        password: m['password'] is String ? m['password'] : null,
        payment_reason: m['payment_reason'] is String ? m['payment_reason'] : null,
        payment_reasonAsByte: m['payment_reasonAsByte'] is List<dynamic> ? m['payment_reasonAsByte'] : null,
        personal_id: m['personal_id'] is String ? m['personal_id'] : null,
        receipt_layout: m['receipt_layout'] is String ? m['receipt_layout'] : null,
        receipt_number: m['receipt_number'] is String ? m['receipt_number'] : null,
        terminal_number: m['terminal_number'] is String ? m['terminal_number'] : null,
        transaction_date_time: m['transaction_date_time'] is String ? m['transaction_date_time'] : null,
        transaction_id: m['transaction_id'] is String ? m['transaction_id'] : null,
        transaction_origin_identifier: m['transaction_origin_identifier'] is String ? m['transaction_origin_identifier'] : null,
        transaction_origin_indicator: m['transaction_origin_indicator'] is String ? m['transaction_origin_indicator'] : null,
        transaction_place: m['transaction_place'] is String ? m['transaction_place'] : null,
        transaction_source_id: m['transaction_source_id'] is String ? m['transaction_source_id'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != amount) {
      m['amount'] = amount;
    }
    if (null != authorization_number) {
      m['authorization_number'] = authorization_number;
    }
    if (null != card_number) {
      m['card_number'] = card_number;
    }
    if (null != currency) {
      m['currency'] = currency;
    }
    if (null != cvc2) {
      m['cvc2'] = cvc2;
    }
    if (null != desired_currency) {
      m['desired_currency'] = desired_currency;
    }
    if (null != ecr_data) {
      m['ecr_data'] = ecr_data;
    }
    if (null != language) {
      m['language'] = language;
    }
    if (null != message_type) {
      m['message_type'] = message_type;
    }
    if (null != password) {
      m['password'] = password;
    }
    if (null != payment_reason) {
      m['payment_reason'] = payment_reason;
    }
    if (null != payment_reasonAsByte) {
      m['payment_reasonAsByte'] = payment_reasonAsByte;
    }
    if (null != personal_id) {
      m['personal_id'] = personal_id;
    }
    if (null != receipt_layout) {
      m['receipt_layout'] = receipt_layout;
    }
    if (null != receipt_number) {
      m['receipt_number'] = receipt_number;
    }
    if (null != terminal_number) {
      m['terminal_number'] = terminal_number;
    }
    if (null != transaction_date_time) {
      m['transaction_date_time'] = transaction_date_time;
    }
    if (null != transaction_id) {
      m['transaction_id'] = transaction_id;
    }
    if (null != transaction_origin_identifier) {
      m['transaction_origin_identifier'] = transaction_origin_identifier;
    }
    if (null != transaction_origin_indicator) {
      m['transaction_origin_indicator'] = transaction_origin_indicator;
    }
    if (null != transaction_place) {
      m['transaction_place'] = transaction_place;
    }
    if (null != transaction_source_id) {
      m['transaction_source_id'] = transaction_source_id;
    }
    return m;
  }
}

class EcrApiLoadMatch {
  /// STRING
  String? amount;
  /// STRING
  String? authorization_number;
  /// STRING
  String? card_number;
  /// STRING
  String? currency;
  /// STRING
  String? cvc2;
  /// STRING
  String? desired_currency;
  /// STRING
  String? ecr_data;
  /// STRING
  String? language;
  /// STRING
  String? message_type;
  /// STRING
  String? password;
  /// STRING
  String? payment_reason;
  /// ARRAY
  List<dynamic>? payment_reasonAsByte;
  /// STRING
  String? personal_id;
  /// STRING
  String? receipt_layout;
  /// STRING
  String? receipt_number;
  /// STRING
  String? terminal_number;
  /// STRING
  String? transaction_date_time;
  /// STRING
  String? transaction_id;
  /// STRING
  String? transaction_origin_identifier;
  /// STRING
  String? transaction_origin_indicator;
  /// STRING
  String? transaction_place;
  /// STRING
  String? transaction_source_id;

  EcrApiLoadMatch({
    this.amount,
    this.authorization_number,
    this.card_number,
    this.currency,
    this.cvc2,
    this.desired_currency,
    this.ecr_data,
    this.language,
    this.message_type,
    this.password,
    this.payment_reason,
    this.payment_reasonAsByte,
    this.personal_id,
    this.receipt_layout,
    this.receipt_number,
    this.terminal_number,
    this.transaction_date_time,
    this.transaction_id,
    this.transaction_origin_identifier,
    this.transaction_origin_indicator,
    this.transaction_place,
    this.transaction_source_id,
  });

  factory EcrApiLoadMatch.fromMap(Map<String, dynamic> m) => EcrApiLoadMatch(
        amount: m['amount'] is String ? m['amount'] : null,
        authorization_number: m['authorization_number'] is String ? m['authorization_number'] : null,
        card_number: m['card_number'] is String ? m['card_number'] : null,
        currency: m['currency'] is String ? m['currency'] : null,
        cvc2: m['cvc2'] is String ? m['cvc2'] : null,
        desired_currency: m['desired_currency'] is String ? m['desired_currency'] : null,
        ecr_data: m['ecr_data'] is String ? m['ecr_data'] : null,
        language: m['language'] is String ? m['language'] : null,
        message_type: m['message_type'] is String ? m['message_type'] : null,
        password: m['password'] is String ? m['password'] : null,
        payment_reason: m['payment_reason'] is String ? m['payment_reason'] : null,
        payment_reasonAsByte: m['payment_reasonAsByte'] is List<dynamic> ? m['payment_reasonAsByte'] : null,
        personal_id: m['personal_id'] is String ? m['personal_id'] : null,
        receipt_layout: m['receipt_layout'] is String ? m['receipt_layout'] : null,
        receipt_number: m['receipt_number'] is String ? m['receipt_number'] : null,
        terminal_number: m['terminal_number'] is String ? m['terminal_number'] : null,
        transaction_date_time: m['transaction_date_time'] is String ? m['transaction_date_time'] : null,
        transaction_id: m['transaction_id'] is String ? m['transaction_id'] : null,
        transaction_origin_identifier: m['transaction_origin_identifier'] is String ? m['transaction_origin_identifier'] : null,
        transaction_origin_indicator: m['transaction_origin_indicator'] is String ? m['transaction_origin_indicator'] : null,
        transaction_place: m['transaction_place'] is String ? m['transaction_place'] : null,
        transaction_source_id: m['transaction_source_id'] is String ? m['transaction_source_id'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != amount) {
      m['amount'] = amount;
    }
    if (null != authorization_number) {
      m['authorization_number'] = authorization_number;
    }
    if (null != card_number) {
      m['card_number'] = card_number;
    }
    if (null != currency) {
      m['currency'] = currency;
    }
    if (null != cvc2) {
      m['cvc2'] = cvc2;
    }
    if (null != desired_currency) {
      m['desired_currency'] = desired_currency;
    }
    if (null != ecr_data) {
      m['ecr_data'] = ecr_data;
    }
    if (null != language) {
      m['language'] = language;
    }
    if (null != message_type) {
      m['message_type'] = message_type;
    }
    if (null != password) {
      m['password'] = password;
    }
    if (null != payment_reason) {
      m['payment_reason'] = payment_reason;
    }
    if (null != payment_reasonAsByte) {
      m['payment_reasonAsByte'] = payment_reasonAsByte;
    }
    if (null != personal_id) {
      m['personal_id'] = personal_id;
    }
    if (null != receipt_layout) {
      m['receipt_layout'] = receipt_layout;
    }
    if (null != receipt_number) {
      m['receipt_number'] = receipt_number;
    }
    if (null != terminal_number) {
      m['terminal_number'] = terminal_number;
    }
    if (null != transaction_date_time) {
      m['transaction_date_time'] = transaction_date_time;
    }
    if (null != transaction_id) {
      m['transaction_id'] = transaction_id;
    }
    if (null != transaction_origin_identifier) {
      m['transaction_origin_identifier'] = transaction_origin_identifier;
    }
    if (null != transaction_origin_indicator) {
      m['transaction_origin_indicator'] = transaction_origin_indicator;
    }
    if (null != transaction_place) {
      m['transaction_place'] = transaction_place;
    }
    if (null != transaction_source_id) {
      m['transaction_source_id'] = transaction_source_id;
    }
    return m;
  }
}

class EcrApiCreateData {
  /// STRING (required at the API)
  String? amount;
  /// STRING
  String? authorization_number;
  /// STRING (required at the API)
  String? card_number;
  /// STRING (required at the API)
  String? currency;
  /// STRING
  String? cvc2;
  /// STRING
  String? desired_currency;
  /// STRING
  String? ecr_data;
  /// STRING
  String? language;
  /// STRING
  String? message_type;
  /// STRING
  String? password;
  /// STRING
  String? payment_reason;
  /// ARRAY
  List<dynamic>? payment_reasonAsByte;
  /// STRING
  String? personal_id;
  /// STRING
  String? receipt_layout;
  /// STRING
  String? receipt_number;
  /// STRING (required at the API)
  String? terminal_number;
  /// STRING (required at the API)
  String? transaction_date_time;
  /// STRING (required at the API)
  String? transaction_id;
  /// STRING
  String? transaction_origin_identifier;
  /// STRING
  String? transaction_origin_indicator;
  /// STRING
  String? transaction_place;
  /// STRING
  String? transaction_source_id;

  EcrApiCreateData({
    this.amount,
    this.authorization_number,
    this.card_number,
    this.currency,
    this.cvc2,
    this.desired_currency,
    this.ecr_data,
    this.language,
    this.message_type,
    this.password,
    this.payment_reason,
    this.payment_reasonAsByte,
    this.personal_id,
    this.receipt_layout,
    this.receipt_number,
    this.terminal_number,
    this.transaction_date_time,
    this.transaction_id,
    this.transaction_origin_identifier,
    this.transaction_origin_indicator,
    this.transaction_place,
    this.transaction_source_id,
  });

  factory EcrApiCreateData.fromMap(Map<String, dynamic> m) => EcrApiCreateData(
        amount: m['amount'] is String ? m['amount'] : null,
        authorization_number: m['authorization_number'] is String ? m['authorization_number'] : null,
        card_number: m['card_number'] is String ? m['card_number'] : null,
        currency: m['currency'] is String ? m['currency'] : null,
        cvc2: m['cvc2'] is String ? m['cvc2'] : null,
        desired_currency: m['desired_currency'] is String ? m['desired_currency'] : null,
        ecr_data: m['ecr_data'] is String ? m['ecr_data'] : null,
        language: m['language'] is String ? m['language'] : null,
        message_type: m['message_type'] is String ? m['message_type'] : null,
        password: m['password'] is String ? m['password'] : null,
        payment_reason: m['payment_reason'] is String ? m['payment_reason'] : null,
        payment_reasonAsByte: m['payment_reasonAsByte'] is List<dynamic> ? m['payment_reasonAsByte'] : null,
        personal_id: m['personal_id'] is String ? m['personal_id'] : null,
        receipt_layout: m['receipt_layout'] is String ? m['receipt_layout'] : null,
        receipt_number: m['receipt_number'] is String ? m['receipt_number'] : null,
        terminal_number: m['terminal_number'] is String ? m['terminal_number'] : null,
        transaction_date_time: m['transaction_date_time'] is String ? m['transaction_date_time'] : null,
        transaction_id: m['transaction_id'] is String ? m['transaction_id'] : null,
        transaction_origin_identifier: m['transaction_origin_identifier'] is String ? m['transaction_origin_identifier'] : null,
        transaction_origin_indicator: m['transaction_origin_indicator'] is String ? m['transaction_origin_indicator'] : null,
        transaction_place: m['transaction_place'] is String ? m['transaction_place'] : null,
        transaction_source_id: m['transaction_source_id'] is String ? m['transaction_source_id'] : null,
      );

  Map<String, dynamic> toMap() {
    final m = <String, dynamic>{};
    if (null != amount) {
      m['amount'] = amount;
    }
    if (null != authorization_number) {
      m['authorization_number'] = authorization_number;
    }
    if (null != card_number) {
      m['card_number'] = card_number;
    }
    if (null != currency) {
      m['currency'] = currency;
    }
    if (null != cvc2) {
      m['cvc2'] = cvc2;
    }
    if (null != desired_currency) {
      m['desired_currency'] = desired_currency;
    }
    if (null != ecr_data) {
      m['ecr_data'] = ecr_data;
    }
    if (null != language) {
      m['language'] = language;
    }
    if (null != message_type) {
      m['message_type'] = message_type;
    }
    if (null != password) {
      m['password'] = password;
    }
    if (null != payment_reason) {
      m['payment_reason'] = payment_reason;
    }
    if (null != payment_reasonAsByte) {
      m['payment_reasonAsByte'] = payment_reasonAsByte;
    }
    if (null != personal_id) {
      m['personal_id'] = personal_id;
    }
    if (null != receipt_layout) {
      m['receipt_layout'] = receipt_layout;
    }
    if (null != receipt_number) {
      m['receipt_number'] = receipt_number;
    }
    if (null != terminal_number) {
      m['terminal_number'] = terminal_number;
    }
    if (null != transaction_date_time) {
      m['transaction_date_time'] = transaction_date_time;
    }
    if (null != transaction_id) {
      m['transaction_id'] = transaction_id;
    }
    if (null != transaction_origin_identifier) {
      m['transaction_origin_identifier'] = transaction_origin_identifier;
    }
    if (null != transaction_origin_indicator) {
      m['transaction_origin_indicator'] = transaction_origin_indicator;
    }
    if (null != transaction_place) {
      m['transaction_place'] = transaction_place;
    }
    if (null != transaction_source_id) {
      m['transaction_source_id'] = transaction_source_id;
    }
    return m;
  }
}

