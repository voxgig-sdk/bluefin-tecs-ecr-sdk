-- BluefinTecsEcr SDK error

local BluefinTecsEcrError = {}
BluefinTecsEcrError.__index = BluefinTecsEcrError


function BluefinTecsEcrError.new(code, msg, ctx)
  local self = setmetatable({}, BluefinTecsEcrError)
  self.is_sdk_error = true
  self.sdk = "BluefinTecsEcr"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function BluefinTecsEcrError:error()
  return self.msg
end


function BluefinTecsEcrError:__tostring()
  return self.msg
end


return BluefinTecsEcrError
