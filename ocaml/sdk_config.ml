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
        ("transport", (Str "none")) ]));
      ("clienttrack", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("clientVersion", (Str "0.0.1")) ]));
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
        ("transport", (Str "none")) ]));
      ("log", (jo [
        ("options", (jo [
          ("active", (Bool true)) ]));
        ("transport", (Str "none")) ]));
      ("metrics", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
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
        ("transport", (Str "none")) ]));
      ("ratelimit", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("burst", (Num (5.)));
          ("rate", (Num (5.))) ]));
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
        ("transport", (Str "wrap")) ]));
      ("telemetry", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("transport", (Str "none")) ]));
      ("test", (jo [
        ("options", (jo [
          ("active", (Bool false)) ]));
        ("transport", (Str "base")) ]));
      ("timeout", (jo [
        ("options", (jo [
          ("active", (Bool false));
          ("ms", (Num (30000.))) ]));
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
            ("req", (Bool true));
            ("short", (Str "Numeric Transaction Amount."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "authorization_number"));
            ("short", (Str "For Gratuity (msg type 0009): the authorization number of the original transaction."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "card_number"));
            ("req", (Bool true));
            ("short", (Str "Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "currency"));
            ("req", (Bool true));
            ("short", (Str "ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\")."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "cvc2"));
            ("short", (Str "Card Verification Code."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "desired_currency"));
            ("short", (Str "ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\")."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "ecr_data"));
            ("short", (Str "ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex)."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "language"));
            ("short", (Str "ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\")."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "message_type"));
            ("short", (Str "Message type code."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "password"));
            ("short", (Str "Password - currently not used (filled with spaces)."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "payment_reason"));
            ("short", (Str "Payment reason (e.g., \"Taxi journey\")."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "payment_reasonAsByte"));
            ("short", (Str "Payment reason represented as a byte array."));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "personal_id"));
            ("short", (Str "Identification of the current user of the ECR or Terminal."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "receipt_layout"));
            ("short", (Str "Receipt layout identifier."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "receipt_number"));
            ("short", (Str "Receipt number."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "terminal_number"));
            ("req", (Bool true));
            ("short", (Str "Terminal number provided by TECS."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_date_time"));
            ("req", (Bool true));
            ("short", (Str "Transaction date and time (format: yyyymmddhhmmss)."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_id"));
            ("req", (Bool true));
            ("short", (Str "Unique transaction identifier."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_origin_identifier"));
            ("short", (Str "Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_origin_indicator"));
            ("short", (Str "Transaction origin indicator: - 0 = Request for card data on PIN PAD."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_place"));
            ("short", (Str "The transaction place; the first 5 characters should contain a formatted zip code."));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_source_id"));
            ("short", (Str "Identification number of the authorization source."));
            ("type", (Str "`$STRING`")) ]) ]));
        ("name", (Str "ecr_api"));
        ("op", (jo [
          ("create", (jo [
            ("input", (Str "data"));
            ("name", (Str "create"));
            ("points", (ja [
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "POST"));
                ("orig", (Str "/makeTransaction"));
                ("parts", (ja [
                  (Str "makeTransaction") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ]));
          ("load", (jo [
            ("input", (Str "data"));
            ("name", (Str "load"));
            ("points", (ja [
              (jo [
                ("args", (empty_map ()));
                ("kind", (Str "http"));
                ("method", (Str "GET"));
                ("orig", (Str "/version"));
                ("parts", (ja [
                  (Str "version") ]));
                ("select", (empty_map ()));
                ("transform", (jo [
                  ("req", (Str "`reqdata`"));
                  ("res", (Str "`body`")) ])) ]) ])) ])) ]));
        ("relations", (jo [
          ("ancestors", (empty_list ())) ])) ])) ])) ])

let make_feature (name : string) : feature =
  match name with
  | "audit" -> audit_feature ()
  | "clienttrack" -> clienttrack_feature ()
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
