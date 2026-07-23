# BluefinTecsEcr SDK feature factory

defmodule BluefinTecsEcr.Features do
  def make_feature(name) do
    case name do
      "test" -> BluefinTecsEcr.Feature.Test.new()
      _ -> BluefinTecsEcr.Feature.new()
    end
  end
end
