# BluefinTecsEcr SDK utility: make_context
require_relative '../core/context'
module BluefinTecsEcrUtilities
  MakeContext = ->(ctxmap, basectx) {
    BluefinTecsEcrContext.new(ctxmap, basectx)
  }
end
