defmodule BluefinTecsEcr.ExistsTest do
  use ExUnit.Case

  test "should create test sdk" do
    testsdk = BluefinTecsEcr.test()
    assert testsdk != nil
  end
end
