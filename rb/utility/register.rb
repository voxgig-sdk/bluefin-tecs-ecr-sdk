# BluefinTecsEcr SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'graphql'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

BluefinTecsEcrUtility.registrar = ->(u) {
  u.clean = BluefinTecsEcrUtilities::Clean
  u.done = BluefinTecsEcrUtilities::Done
  u.make_error = BluefinTecsEcrUtilities::MakeError
  u.feature_add = BluefinTecsEcrUtilities::FeatureAdd
  u.feature_hook = BluefinTecsEcrUtilities::FeatureHook
  u.feature_init = BluefinTecsEcrUtilities::FeatureInit
  u.fetcher = BluefinTecsEcrUtilities::Fetcher
  u.make_fetch_def = BluefinTecsEcrUtilities::MakeFetchDef
  u.make_context = BluefinTecsEcrUtilities::MakeContext
  u.make_options = BluefinTecsEcrUtilities::MakeOptions
  u.make_request = BluefinTecsEcrUtilities::MakeRequest
  u.make_response = BluefinTecsEcrUtilities::MakeResponse
  u.make_result = BluefinTecsEcrUtilities::MakeResult
  u.make_point = BluefinTecsEcrUtilities::MakePoint
  u.make_spec = BluefinTecsEcrUtilities::MakeSpec
  u.make_url = BluefinTecsEcrUtilities::MakeUrl
  u.param = BluefinTecsEcrUtilities::Param
  u.prepare_auth = BluefinTecsEcrUtilities::PrepareAuth
  u.prepare_body = BluefinTecsEcrUtilities::PrepareBody
  u.prepare_headers = BluefinTecsEcrUtilities::PrepareHeaders
  u.prepare_method = BluefinTecsEcrUtilities::PrepareMethod
  u.prepare_params = BluefinTecsEcrUtilities::PrepareParams
  u.prepare_path = BluefinTecsEcrUtilities::PreparePath
  u.prepare_query = BluefinTecsEcrUtilities::PrepareQuery
  u.graphql_body = BluefinTecsEcrUtilities::GraphqlBody
  u.graphql_errors = BluefinTecsEcrUtilities::GraphqlErrors
  u.result_basic = BluefinTecsEcrUtilities::ResultBasic
  u.result_body = BluefinTecsEcrUtilities::ResultBody
  u.result_headers = BluefinTecsEcrUtilities::ResultHeaders
  u.transform_request = BluefinTecsEcrUtilities::TransformRequest
  u.transform_response = BluefinTecsEcrUtilities::TransformResponse
}
