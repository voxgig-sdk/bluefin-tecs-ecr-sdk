-- Generated API configuration (make_config) and the feature factory.

module SdkConfig (makeConfig, makeFeature) where

import VoxgigStruct (Value)
import SdkHelpers (CV (..), buildCV)
import SdkTypes (Feature)
import qualified SdkFeatures as F

makeConfig :: IO Value
makeConfig = buildCV (CVMap [("entity", (CVMap [("ecr_api", (CVMap [("fields", (CVList [(CVMap [("active", (CVBool True)), ("index$", (CVNum (0))), ("name", (CVStr "amount")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (1))), ("name", (CVStr "authorization_number")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (2))), ("name", (CVStr "card_number")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (3))), ("name", (CVStr "currency")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (4))), ("name", (CVStr "cvc2")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (5))), ("name", (CVStr "desired_currency")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (6))), ("name", (CVStr "ecr_data")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (7))), ("name", (CVStr "language")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (8))), ("name", (CVStr "message_type")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (9))), ("name", (CVStr "password")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (10))), ("name", (CVStr "payment_reason")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (11))), ("name", (CVStr "payment_reason_as_byte")), ("req", (CVBool False)), ("type", (CVStr "`$ARRAY`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (12))), ("name", (CVStr "personal_id")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (13))), ("name", (CVStr "receipt_layout")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (14))), ("name", (CVStr "receipt_number")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (15))), ("name", (CVStr "terminal_number")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (16))), ("name", (CVStr "transaction_date_time")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (17))), ("name", (CVStr "transaction_id")), ("req", (CVBool True)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (18))), ("name", (CVStr "transaction_origin_identifier")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (19))), ("name", (CVStr "transaction_origin_indicator")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (20))), ("name", (CVStr "transaction_place")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))]), (CVMap [("active", (CVBool True)), ("index$", (CVNum (21))), ("name", (CVStr "transaction_source_id")), ("req", (CVBool False)), ("type", (CVStr "`$STRING`"))])])), ("name", (CVStr "ecr_api")), ("op", (CVMap [("create", (CVMap [("input", (CVStr "data")), ("key$", (CVStr "create")), ("name", (CVStr "create")), ("points", (CVList [(CVMap [("active", (CVBool True)), ("args", (CVMap [])), ("index$", (CVNum (0))), ("method", (CVStr "POST")), ("orig", (CVStr "/makeTransaction")), ("parts", (CVList [(CVStr "makeTransaction")])), ("select", (CVMap [])), ("transform", (CVMap [("req", (CVStr "`reqdata`")), ("res", (CVStr "`body`"))]))])]))])), ("load", (CVMap [("input", (CVStr "data")), ("key$", (CVStr "load")), ("name", (CVStr "load")), ("points", (CVList [(CVMap [("active", (CVBool True)), ("args", (CVMap [])), ("index$", (CVNum (0))), ("method", (CVStr "GET")), ("orig", (CVStr "/version")), ("parts", (CVList [(CVStr "version")])), ("select", (CVMap [])), ("transform", (CVMap [("req", (CVStr "`reqdata`")), ("res", (CVStr "`body`"))]))])]))]))])), ("relations", (CVMap [("ancestors", (CVList []))]))]))])), ("feature", (CVMap [("test", (CVMap [("options", (CVMap [("active", (CVBool False))]))]))])), ("main", (CVMap [("name", (CVStr "BluefinTecsEcr"))])), ("options", (CVMap [("auth", (CVMap [("prefix", (CVStr "Bearer"))])), ("base", (CVStr "https://test.tecs.at/tecsclientrest-auth")), ("entity", (CVMap [("ecr_api", (CVMap []))])), ("headers", (CVMap [("content-type", (CVStr "application/json"))]))]))])

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
