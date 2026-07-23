# BluefinTecsEcr SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module BluefinTecsEcrFeatures
  def self.make_feature(name)
    case name
    when "base"
      BluefinTecsEcrBaseFeature.new
    when "test"
      BluefinTecsEcrTestFeature.new
    else
      BluefinTecsEcrBaseFeature.new
    end
  end
end
