(* Generated API configuration (mirrors go core/config.go).
 *
 * make_config () — the embedded API model as a voxgig struct value.
 * make_feature name — the N-feature-safe factory the client uses. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Sdk_features

let make_config () : value =
  (jo [
    ("main", (jo [
      ("name", (Str "BluefinTecsEcr"));
      ("slug", (Str "bluefin-tecs-ecr"));
      ("version", (Str "0.1.1"));
      ("target", (Str "ocaml")) ]));
    ("feature", (jo [
      ("audit", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("actor", (Str "anonymous"));
          ("max", (Num (1000.))) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("sink", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("clienttrack", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("clientVersion", (Str "0.0.1")) ]));
        ("optspec", (jo [
          ("clientName", (Str "`$STRING`"));
          ("clientVersion", (Str "`$STRING`"));
          ("headers", (Str "`$MAP`"));
          ("idgen", (Str "`$FUNCTION`"));
          ("sessionId", (Str "`$STRING`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("debug", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("max", (Num (100.)));
          ("redact", (ja [
            (Str "authorization");
            (Str "cookie");
            (Str "set-cookie");
            (Str "api-key");
            (Str "apikey");
            (Str "x-api-key");
            (Str "idempotency-key") ])) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("onEntry", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("idempotency", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("header", (Str "Idempotency-Key"));
          ("methods", (ja [
            (Str "POST");
            (Str "PUT");
            (Str "PATCH");
            (Str "DELETE") ]));
          ("ops", (ja [
            (Str "create");
            (Str "update");
            (Str "remove") ])) ]));
        ("optspec", (jo [
          ("keygen", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("log", (jo [
        ("options", (jo [
          ("active", (Bool true)) ]));
        ("optspec", (jo [
          ("level", (Str "`$STRING`"));
          ("logger", (Str "`$ANY`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("metrics", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("paging", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("afterVar", (Str "after"));
          ("cursorParam", (Str "cursor"));
          ("firstVar", (Str "first"));
          ("limitParam", (Str "limit"));
          ("pageParam", (Str "page"));
          ("startPage", (Num (1.))) ]));
        ("optspec", (jo [
          ("limit", (Str "`$NUMBER`"));
          ("ops", (Str "`$LIST`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("ratelimit", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("burst", (Num (5.)));
          ("rate", (Num (5.))) ]));
        ("optspec", (jo [
          ("now", (Str "`$FUNCTION`"));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("retry", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("factor", (Num (2.)));
          ("maxDelay", (Num (2000.)));
          ("minDelay", (Num (50.)));
          ("retries", (Num (2.)));
          ("statuses", (ja [
            (Num (408.));
            (Num (425.));
            (Num (429.));
            (Num (500.));
            (Num (502.));
            (Num (503.));
            (Num (504.)) ])) ]));
        ("optspec", (jo [
          ("jitter", (Str "`$BOOLEAN`"));
          ("sleep", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ]));
      ("telemetry", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("exporter", (Str "`$FUNCTION`"));
          ("headers", (Str "`$MAP`"));
          ("idgen", (Str "`$FUNCTION`"));
          ("now", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "none")) ]));
      ("test", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("optspec", (jo [
          ("entity", (Str "`$MAP`"));
          ("net", (Str "`$MAP`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "base")) ]));
      ("timeout", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("ms", (Num (30000.))) ]));
        ("optspec", (jo [
          ("clearTimer", (Str "`$FUNCTION`"));
          ("setTimer", (Str "`$FUNCTION`")) ]));
        ("strict", (Bool false));
        ("transport", (Str "wrap")) ])) ]));
    ("options", (jo [
      ("base", (Str "https://test.tecs.at/tecsclientrest-auth"));
      ("auth", (jo [
        ("prefix", (Str "Bearer")) ]));
      ("headers", (jo [
        ("content-type", (Str "application/json")) ]));
      ("entity", (jo [
        ("ecr_api", (empty_map ())) ])) ]));
    ("entity", (jo [
      ("ecr_api", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "amount"));
            ("title", (Str "Amount"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Numeric Transaction Amount.")) ]);
          (jo [
            ("name", (Str "authorization_number"));
            ("title", (Str "Authorization Number"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "For Gratuity (msg type 0009): the authorization number of the original transaction.")) ]);
          (jo [
            ("name", (Str "card_number"));
            ("title", (Str "Card Number"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty.")) ]);
          (jo [
            ("name", (Str "currency"));
            ("title", (Str "Currency"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\").")) ]);
          (jo [
            ("name", (Str "cvc2"));
            ("title", (Str "Cvc2"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Card Verification Code.")) ]);
          (jo [
            ("name", (Str "desired_currency"));
            ("title", (Str "Desired Currency"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\").")) ]);
          (jo [
            ("name", (Str "ecr_data"));
            ("title", (Str "Ecr Data"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).")) ]);
          (jo [
            ("name", (Str "language"));
            ("title", (Str "Language"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\").")) ]);
          (jo [
            ("name", (Str "message_type"));
            ("title", (Str "Message Type"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Message type code.")) ]);
          (jo [
            ("name", (Str "password"));
            ("title", (Str "Password"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Password - currently not used (filled with spaces).")) ]);
          (jo [
            ("name", (Str "payment_reason"));
            ("title", (Str "Payment Reason"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Payment reason (e.g., \"Taxi journey\").")) ]);
          (jo [
            ("name", (Str "payment_reasonAsByte"));
            ("title", (Str "Payment Reason As Byte"));
            ("type", (Str "`$ARRAY`"));
            ("short", (Str "Payment reason represented as a byte array.")) ]);
          (jo [
            ("name", (Str "personal_id"));
            ("title", (Str "Personal Id"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Identification of the current user of the ECR or Terminal.")) ]);
          (jo [
            ("name", (Str "receipt_layout"));
            ("title", (Str "Receipt Layout"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Receipt layout identifier.")) ]);
          (jo [
            ("name", (Str "receipt_number"));
            ("title", (Str "Receipt Number"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Receipt number.")) ]);
          (jo [
            ("name", (Str "terminal_number"));
            ("title", (Str "Terminal Number"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Terminal number provided by TECS.")) ]);
          (jo [
            ("name", (Str "transaction_date_time"));
            ("title", (Str "Transaction Date Time"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Transaction date and time (format: yyyymmddhhmmss).")) ]);
          (jo [
            ("name", (Str "transaction_id"));
            ("title", (Str "Transaction Id"));
            ("type", (Str "`$STRING`"));
            ("req", (Bool true));
            ("short", (Str "Unique transaction identifier.")) ]);
          (jo [
            ("name", (Str "transaction_origin_identifier"));
            ("title", (Str "Transaction Origin Identifier"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance")) ]);
          (jo [
            ("name", (Str "transaction_origin_indicator"));
            ("title", (Str "Transaction Origin Indicator"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Transaction origin indicator: - 0 = Request for card data on PIN PAD.")) ]);
          (jo [
            ("name", (Str "transaction_place"));
            ("title", (Str "Transaction Place"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "The transaction place; the first 5 characters should contain a formatted zip code.")) ]);
          (jo [
            ("name", (Str "transaction_source_id"));
            ("title", (Str "Transaction Source Id"));
            ("type", (Str "`$STRING`"));
            ("short", (Str "Identification number of the authorization source.")) ]) ]));
        ("name", (Str "ecr_api"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/makeTransaction"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "makeTransaction")) ]) ]));
                ("parts", (ja [
                  (Str "makeTransaction") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/version"));
                ("segments", (ja [
                  (jo [
                    ("lit", (Str "version")) ]) ]));
                ("parts", (ja [
                  (Str "version") ]));
                ("rename", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ]));
                ("args", (empty_map ()));
                ("select", (empty_map ())) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ])) ])) ])

(* The plugin definitions the model selected, per feature: none - no
 * plugin-bearing feature is active in this SDK. *)
let feature_plugins (_name : string) = []

let make_feature (name : string) : feature =
  match name with
  | "audit" -> audit_feature ()
  | "clienttrack" -> clienttrack_feature ()
  | "debug" -> debug_feature ()
  | "idempotency" -> idempotency_feature ()
  | "log" -> log_feature ()
  | "metrics" -> metrics_feature ()
  | "paging" -> paging_feature ()
  | "ratelimit" -> ratelimit_feature ()
  | "retry" -> retry_feature ()
  | "telemetry" -> telemetry_feature ()
  | "test" -> test_feature ()
  | "timeout" -> timeout_feature ()
  | _ -> base_feature ()
