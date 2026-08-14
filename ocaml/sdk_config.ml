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
      ("name", (Str "BluefinTecsEcr")) ]));
    ("feature", (jo [
      ("test", (jo [
        ("options", (jo [
          ("active", (Bool false)) ])) ])) ]));
    ("options", (jo [
      ("base", (Str "https://test.tecs.at/tecsclientrest-auth"));
      ("headers", (jo [
        ("content-type", (Str "application/json")) ]));
      ("entity", (jo [
        ("ecr_api", (empty_map ())) ]));
      ("auth", (jo [
        ("prefix", (Str "Bearer")) ])) ]));
    ("entity", (jo [
      ("ecr_api", (jo [
        ("fields", (ja [
          (jo [
            ("name", (Str "amount"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "authorization_number"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "card_number"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "currency"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "cvc2"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "desired_currency"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "ecr_data"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "language"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "message_type"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "password"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "payment_reason"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "payment_reasonAsByte"));
            ("type", (Str "`$ARRAY`")) ]);
          (jo [
            ("name", (Str "personal_id"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "receipt_layout"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "receipt_number"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "terminal_number"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_date_time"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_id"));
            ("req", (Bool true));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_origin_identifier"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_origin_indicator"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_place"));
            ("type", (Str "`$STRING`")) ]);
          (jo [
            ("name", (Str "transaction_source_id"));
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
  | "test" -> test_feature ()
  | _ -> base_feature ()
