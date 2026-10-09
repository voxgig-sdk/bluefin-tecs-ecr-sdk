# BluefinTecsEcr SDK utility: prepare_body
require_relative 'media'
module BluefinTecsEcrUtilities
  PrepareBody = ->(ctx) {
    return nil unless ctx.op.input == "data"
    return BluefinTecsEcrUtilities.raw_body(ctx.reqdata) if BluefinTecsEcrUtilities.raw_request?(ctx.point)
    ctx.utility.transform_request.call(ctx)
  }
end
