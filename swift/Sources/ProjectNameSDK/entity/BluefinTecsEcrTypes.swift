// Typed models for the BluefinTecsEcr SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types are mapped
// from the canonical type sentinels. Do not edit by hand.
//
// These are DOCUMENTARY: the SDK runtime is dynamic (ops take/return the
// `Value` enum), so nothing consumes these structs yet — they mirror the
// entity/op shapes for reference and IDE support.

import Foundation

/// EcrApi is the typed data model for the ecr_api entity.
public struct EcrApi {
  public var amount: String
  public var authorizationNumber: String?
  public var cardNumber: String
  public var currency: String
  public var cvc2: String?
  public var desiredCurrency: String?
  public var ecrData: String?
  public var language: String?
  public var messageType: String?
  public var password: String?
  public var paymentReason: String?
  public var paymentReasonAsByte: [Value]?
  public var personalId: String?
  public var receiptLayout: String?
  public var receiptNumber: String?
  public var terminalNumber: String
  public var transactionDateTime: String
  public var transactionId: String
  public var transactionOriginIdentifier: String?
  public var transactionOriginIndicator: String?
  public var transactionPlace: String?
  public var transactionSourceId: String?
}

/// EcrApiLoadMatch is the typed request payload for EcrApi.load.
public struct EcrApiLoadMatch {
  public var amount: String?
  public var authorizationNumber: String?
  public var cardNumber: String?
  public var currency: String?
  public var cvc2: String?
  public var desiredCurrency: String?
  public var ecrData: String?
  public var language: String?
  public var messageType: String?
  public var password: String?
  public var paymentReason: String?
  public var paymentReasonAsByte: [Value]?
  public var personalId: String?
  public var receiptLayout: String?
  public var receiptNumber: String?
  public var terminalNumber: String?
  public var transactionDateTime: String?
  public var transactionId: String?
  public var transactionOriginIdentifier: String?
  public var transactionOriginIndicator: String?
  public var transactionPlace: String?
  public var transactionSourceId: String?
}

/// EcrApiCreateData is the typed request payload for EcrApi.create.
public struct EcrApiCreateData {
  public var amount: String
  public var authorizationNumber: String?
  public var cardNumber: String
  public var currency: String
  public var cvc2: String?
  public var desiredCurrency: String?
  public var ecrData: String?
  public var language: String?
  public var messageType: String?
  public var password: String?
  public var paymentReason: String?
  public var paymentReasonAsByte: [Value]?
  public var personalId: String?
  public var receiptLayout: String?
  public var receiptNumber: String?
  public var terminalNumber: String
  public var transactionDateTime: String
  public var transactionId: String
  public var transactionOriginIdentifier: String?
  public var transactionOriginIndicator: String?
  public var transactionPlace: String?
  public var transactionSourceId: String?
}

