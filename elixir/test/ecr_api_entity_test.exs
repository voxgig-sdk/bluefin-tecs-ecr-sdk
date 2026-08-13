# EcrApi entity test (offline, mock transport)

defmodule BluefinTecsEcr.EcrApiEntityTest do
  use ExUnit.Case

  alias Voxgig.Struct, as: S
  alias BluefinTecsEcr.Helpers, as: H
  alias BluefinTecsEcr.Json

  defp fixture do
    Json.parse(File.read!("../.sdk/test/entity/ecr_api/EcrApiTestData.json"))
  end

  defp mk_sdk do
    existing = H.or_(S.getpath(fixture(), "existing"), S.jm([]))
    BluefinTecsEcr.test(S.jm(["entity", existing]))
  end

  defp first_id do
    existing = H.or_(S.getpath(fixture(), "existing.ecr_api"), S.jm([]))
    keys = S.keysof(existing)
    if keys == [], do: nil, else: hd(keys)
  end

  test "should create instance" do
    sdk = BluefinTecsEcr.test()
    ent = BluefinTecsEcr.ecr_api(sdk)
    assert ent != nil
  end

  test "should load an existing record" do
    id = first_id()

    if id != nil do
      sdk = mk_sdk()
      ent = BluefinTecsEcr.ecr_api(sdk)
      loaded = BluefinTecsEcr.Entity.EcrApi.load(ent, S.jm(["id", id]))
      rec = BluefinTecsEcr.EntityBase.data_get(loaded)
      assert S.ismap(rec)
      assert S.getprop(rec, "id") == id
    end
  end

  test "should create then read back" do
    sdk = BluefinTecsEcr.test(S.jm(["entity", S.jm(["ecr_api", S.jm([])])]))
    ent = BluefinTecsEcr.ecr_api(sdk)
    created = BluefinTecsEcr.Entity.EcrApi.create(ent, S.jm(["name", "test-create"]))
    made = BluefinTecsEcr.EntityBase.data_get(created)
    assert S.ismap(made)
    assert S.getprop(made, "id") != nil
  end
end
