-- Generated API configuration (make_config) and the feature factory.

module SdkConfig (makeConfig, makeFeature) where

import VoxgigStruct (Value)
import SdkHelpers (CV (..), buildCV)
import SdkTypes (Feature)
import qualified SdkFeatures as F

makeConfig :: IO Value
makeConfig = buildCV (CVMap [("entity", (CVMap [("ecr_api", (CVMap [("fields", (CVList [(CVMap [("name", (CVStr "amount")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "authorization_number")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "card_number")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "currency")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "cvc2")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "desired_currency")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "ecr_data")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "language")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "message_type")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "password")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "payment_reason")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "payment_reasonAsByte")), ("type", (CVStr "`$ARRAY`"))]), (CVMap [("name", (CVStr "personal_id")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "receipt_layout")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "receipt_number")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "terminal_number")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "transaction_date_time")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "transaction_id")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "transaction_origin_identifier")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "transaction_origin_indicator")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "transaction_place")), ("type", (CVStr "`$STRING`"))]), (CVMap [("name", (CVStr "transaction_source_id")), ("type", (CVStr "`$STRING`"))])])), ("name", (CVStr "ecr_api")), ("op", (CVMap [("create", (CVMap [("input", (CVStr "data")), ("name", (CVStr "create")), ("points", (CVList [(CVMap [("args", (CVMap [])), ("kind", (CVStr "http")), ("method", (CVStr "POST")), ("orig", (CVStr "/makeTransaction")), ("parts", (CVList [(CVStr "makeTransaction")])), ("select", (CVMap [])), ("transform", (CVMap [("req", (CVStr "`reqdata`")), ("res", (CVStr "`body`"))]))])]))])), ("load", (CVMap [("input", (CVStr "data")), ("name", (CVStr "load")), ("points", (CVList [(CVMap [("args", (CVMap [])), ("kind", (CVStr "http")), ("method", (CVStr "GET")), ("orig", (CVStr "/version")), ("parts", (CVList [(CVStr "version")])), ("select", (CVMap [])), ("transform", (CVMap [("req", (CVStr "`reqdata`")), ("res", (CVStr "`body`"))]))])]))]))])), ("relations", (CVMap [("ancestors", (CVList []))]))]))])), ("feature", (CVMap [("test", (CVMap [("options", (CVMap [("active", (CVBool False))]))]))])), ("main", (CVMap [("name", (CVStr "BluefinTecsEcr"))])), ("options", (CVMap [("auth", (CVMap [("prefix", (CVStr "Bearer"))])), ("base", (CVStr "https://test.tecs.at/tecsclientrest-auth")), ("entity", (CVMap [("ecr_api", (CVMap []))])), ("headers", (CVMap [("content-type", (CVStr "application/json"))]))]))])

makeFeature :: String -> IO Feature
makeFeature name = case name of
  "log" -> F.logFeature
  "test" -> F.testFeature
  "retry" -> F.retryFeature
  "timeout" -> F.timeoutFeature
  "ratelimit" -> F.ratelimitFeature
  "cache" -> F.cacheFeature
  "idempotency" -> F.idempotencyFeature
  "paging" -> F.pagingFeature
  "streaming" -> F.streamingFeature
  "proxy" -> F.proxyFeature
  "telemetry" -> F.telemetryFeature
  "metrics" -> F.metricsFeature
  "debug" -> F.debugFeature
  "audit" -> F.auditFeature
  "clienttrack" -> F.clienttrackFeature
  "rbac" -> F.rbacFeature
  "netsim" -> F.netsimFeature
  _ -> F.baseFeature
