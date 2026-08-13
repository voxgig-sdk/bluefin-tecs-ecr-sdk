(* Generated ecr_api entity test. *)

open Voxgig_struct
open Sdk_types
open Sdk_helpers
open Testutil

let () =
  test "ecr_api.entity_instance" (fun () ->
      let client = Sdk_client.test () in
      let ent = Sdk_client.ecr_api client Noval in
      check_str "name" ent.e_name "ecr_api")

let () =
  test "ecr_api.seeded_ops" (fun () ->
      let record = jo [("id", Str "ecr_api01")] in
      let seed = jo [("ecr_api",
                      jo [("ecr_api01", record)])] in
      let client = Sdk_client.test_with (jo [("entity", seed)]) Noval in
      let ent = Sdk_client.ecr_api client Noval in
      ignore ent;
      let loaded = ent.e_load (jo [("id", Str "ecr_api01")]) Noval in
      let loaded_data = loaded.e_data_get () in
      check "load data is a map" (ismap loaded_data);
      ())
