package voxgigbluefintecsecrsdk

import (
	"github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go/core"
	"github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go/entity"
	"github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go/feature"
	_ "github.com/voxgig-sdk/bluefin-tecs-ecr-sdk/go/utility"
)

// Type aliases preserve external API.
type BluefinTecsEcrSDK = core.BluefinTecsEcrSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type BluefinTecsEcrEntity = core.BluefinTecsEcrEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type BluefinTecsEcrError = core.BluefinTecsEcrError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewAuditFeatureFunc = func() core.Feature {
		return feature.NewAuditFeature()
	}
	core.NewClienttrackFeatureFunc = func() core.Feature {
		return feature.NewClienttrackFeature()
	}
	core.NewIdempotencyFeatureFunc = func() core.Feature {
		return feature.NewIdempotencyFeature()
	}
	core.NewLogFeatureFunc = func() core.Feature {
		return feature.NewLogFeature()
	}
	core.NewMetricsFeatureFunc = func() core.Feature {
		return feature.NewMetricsFeature()
	}
	core.NewPagingFeatureFunc = func() core.Feature {
		return feature.NewPagingFeature()
	}
	core.NewRatelimitFeatureFunc = func() core.Feature {
		return feature.NewRatelimitFeature()
	}
	core.NewRetryFeatureFunc = func() core.Feature {
		return feature.NewRetryFeature()
	}
	core.NewTelemetryFeatureFunc = func() core.Feature {
		return feature.NewTelemetryFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewTimeoutFeatureFunc = func() core.Feature {
		return feature.NewTimeoutFeature()
	}
	core.NewEcrApiEntityFunc = func(client *core.BluefinTecsEcrSDK, entopts map[string]any) core.BluefinTecsEcrEntity {
		return entity.NewEcrApiEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewBluefinTecsEcrSDK = core.NewBluefinTecsEcrSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var SharedConfig = core.SharedConfig

// No-arg convenience constructors. Go has no default-argument syntax,
// so these aliases let callers write `sdk.New()` / `sdk.Test()`
// instead of `sdk.NewBluefinTecsEcrSDK(nil)` / `sdk.TestSDK(nil, nil)`
// for the common no-options case.
func New() *BluefinTecsEcrSDK  { return NewBluefinTecsEcrSDK(nil) }
func Test() *BluefinTecsEcrSDK { return TestSDK(nil, nil) }
var NewBaseFeature = feature.NewBaseFeature
var NewAuditFeature = feature.NewAuditFeature
var NewClienttrackFeature = feature.NewClienttrackFeature
var NewIdempotencyFeature = feature.NewIdempotencyFeature
var NewLogFeature = feature.NewLogFeature
var NewMetricsFeature = feature.NewMetricsFeature
var NewPagingFeature = feature.NewPagingFeature
var NewRatelimitFeature = feature.NewRatelimitFeature
var NewRetryFeature = feature.NewRetryFeature
var NewTelemetryFeature = feature.NewTelemetryFeature
var NewTestFeature = feature.NewTestFeature
var NewTimeoutFeature = feature.NewTimeoutFeature
