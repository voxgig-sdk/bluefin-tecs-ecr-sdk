// BluefinTecsEcr SDK - generated model configuration and feature
// factory. GENERATED from the API model - do not edit by hand.

import Foundation

public enum SdkConfig {
  public static func makeConfig() -> VMap {
    let json = #"""
{"main":{"name":"BluefinTecsEcr","slug":"bluefin-tecs-ecr","version":"0.1.1","target":"swift"},"feature":{"audit":{"options":{"active":false,"actor":"anonymous","max":1000},"optspec":{"now":"`$FUNCTION`","sink":"`$FUNCTION`"},"strict":false,"transport":"none"},"clienttrack":{"options":{"active":false,"clientVersion":"0.0.1"},"optspec":{"clientName":"`$STRING`","clientVersion":"`$STRING`","headers":"`$MAP`","idgen":"`$FUNCTION`","sessionId":"`$STRING`"},"strict":false,"transport":"none"},"debug":{"options":{"active":false,"max":100,"redact":["authorization","cookie","set-cookie","api-key","apikey","x-api-key","idempotency-key"]},"optspec":{"now":"`$FUNCTION`","onEntry":"`$FUNCTION`"},"strict":false,"transport":"none"},"idempotency":{"options":{"active":false,"header":"Idempotency-Key","methods":["POST","PUT","PATCH","DELETE"],"ops":["create","update","remove"]},"optspec":{"keygen":"`$FUNCTION`"},"strict":false,"transport":"none"},"log":{"options":{"active":true},"optspec":{"level":"`$STRING`","logger":"`$ANY`"},"strict":false,"transport":"none"},"metrics":{"options":{"active":false},"optspec":{"now":"`$FUNCTION`"},"strict":false,"transport":"none"},"paging":{"options":{"active":false,"afterVar":"after","cursorParam":"cursor","firstVar":"first","limitParam":"limit","pageParam":"page","startPage":1},"optspec":{"limit":"`$NUMBER`","ops":"`$LIST`"},"strict":false,"transport":"none"},"ratelimit":{"options":{"active":false,"burst":5,"rate":5},"optspec":{"now":"`$FUNCTION`","sleep":"`$FUNCTION`"},"strict":false,"transport":"wrap"},"retry":{"options":{"active":false,"factor":2,"maxDelay":2000,"minDelay":50,"retries":2,"statuses":[408,425,429,500,502,503,504]},"optspec":{"jitter":"`$BOOLEAN`","sleep":"`$FUNCTION`"},"strict":false,"transport":"wrap"},"telemetry":{"options":{"active":false},"optspec":{"exporter":"`$FUNCTION`","headers":"`$MAP`","idgen":"`$FUNCTION`","now":"`$FUNCTION`"},"strict":false,"transport":"none"},"test":{"options":{"active":false},"optspec":{"entity":"`$MAP`","net":"`$MAP`"},"strict":false,"transport":"base"},"timeout":{"options":{"active":false,"ms":30000},"optspec":{"clearTimer":"`$FUNCTION`","setTimer":"`$FUNCTION`"},"strict":false,"transport":"wrap"}},"options":{"base":"https://test.tecs.at/tecsclientrest-auth","auth":{"prefix":"Bearer"},"headers":{"content-type":"application/json"},"entity":{"ecr_api":{}}},"entity":{"ecr_api":{"fields":[{"name":"amount","title":"Amount","type":"`$STRING`","req":true,"short":"Numeric Transaction Amount."},{"name":"authorization_number","title":"Authorization Number","type":"`$STRING`","short":"For Gratuity (msg type 0009): the authorization number of the original transaction."},{"name":"card_number","title":"Card Number","type":"`$STRING`","req":true,"short":"Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty."},{"name":"currency","title":"Currency","type":"`$STRING`","req":true,"short":"ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\")."},{"name":"cvc2","title":"Cvc2","type":"`$STRING`","short":"Card Verification Code."},{"name":"desired_currency","title":"Desired Currency","type":"`$STRING`","short":"ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\")."},{"name":"ecr_data","title":"Ecr Data","type":"`$STRING`","short":"ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex)."},{"name":"language","title":"Language","type":"`$STRING`","short":"ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\")."},{"name":"message_type","title":"Message Type","type":"`$STRING`","short":"Message type code."},{"name":"password","title":"Password","type":"`$STRING`","short":"Password - currently not used (filled with spaces)."},{"name":"payment_reason","title":"Payment Reason","type":"`$STRING`","short":"Payment reason (e.g., \"Taxi journey\")."},{"name":"payment_reasonAsByte","title":"Payment Reason As Byte","type":"`$ARRAY`","short":"Payment reason represented as a byte array."},{"name":"personal_id","title":"Personal Id","type":"`$STRING`","short":"Identification of the current user of the ECR or Terminal."},{"name":"receipt_layout","title":"Receipt Layout","type":"`$STRING`","short":"Receipt layout identifier."},{"name":"receipt_number","title":"Receipt Number","type":"`$STRING`","short":"Receipt number."},{"name":"terminal_number","title":"Terminal Number","type":"`$STRING`","req":true,"short":"Terminal number provided by TECS."},{"name":"transaction_date_time","title":"Transaction Date Time","type":"`$STRING`","req":true,"short":"Transaction date and time (format: yyyymmddhhmmss)."},{"name":"transaction_id","title":"Transaction Id","type":"`$STRING`","req":true,"short":"Unique transaction identifier."},{"name":"transaction_origin_identifier","title":"Transaction Origin Identifier","type":"`$STRING`","short":"Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance"},{"name":"transaction_origin_indicator","title":"Transaction Origin Indicator","type":"`$STRING`","short":"Transaction origin indicator: - 0 = Request for card data on PIN PAD."},{"name":"transaction_place","title":"Transaction Place","type":"`$STRING`","short":"The transaction place; the first 5 characters should contain a formatted zip code."},{"name":"transaction_source_id","title":"Transaction Source Id","type":"`$STRING`","short":"Identification number of the authorization source."}],"name":"ecr_api","op":{"create":{"input":"data","name":"create","points":[{"kind":"http","method":"POST","orig":"/makeTransaction","segments":[{"lit":"makeTransaction"}],"parts":["makeTransaction"],"rename":{},"transform":{"req":"`reqdata`","res":"`body`"},"args":{},"select":{}}]},"load":{"input":"data","name":"load","points":[{"kind":"http","method":"GET","orig":"/version","segments":[{"lit":"version"}],"parts":["version"],"rename":{},"transform":{"req":"`reqdata`","res":"`body`"},"args":{},"select":{}}]}},"relations":{"ancestors":[]}}}}
"""#
    return (try? JSON.parse(json))?.asMap ?? VMap()
  }

  // SHARED CONFIG (sdkgen rung L2).
  //
  // The SDK reads the config on every request and never writes to it, so one
  // instance is shared by every client rather than rebuilt per client - the
  // difference between parsing the embedded JSON once and once per client.
  //
  // A static let in an enum is lazy and initialised exactly once, thread-safe
  // via swift_once.
  //
  // The result is SHARED: treat it as read-only. Callers that need to mutate
  // should use makeConfig, which always parses a fresh copy.
  private static let sharedConfigVal: VMap = makeConfig()

  public static func sharedConfig() -> VMap {
    return sharedConfigVal
  }

  public static func makeFeature(_ name: String) -> BaseFeature {
    switch name {
    case "audit": return AuditFeature()
    case "clienttrack": return ClienttrackFeature()
    case "debug": return DebugFeature()
    case "idempotency": return IdempotencyFeature()
    case "log": return LogFeature()
    case "metrics": return MetricsFeature()
    case "paging": return PagingFeature()
    case "ratelimit": return RatelimitFeature()
    case "retry": return RetryFeature()
    case "telemetry": return TelemetryFeature()
    case "test": return TestFeature()
    case "timeout": return TimeoutFeature()
    default: return BaseFeature()
    }
  }

  // The plugin definitions the model selected per feature, as [Any] so a
  // feature can consume them without core naming the plugin module's
  // types. Empty when no active feature declares active plugin groups for
  // this target.
  private static let featurePluginsVal: [String: [Any]] = [:]

  // featurePlugins is the definitions list for one feature's chain.
  public static func featurePlugins(_ name: String) -> [Any] {
    return featurePluginsVal[name] ?? []
  }
}
