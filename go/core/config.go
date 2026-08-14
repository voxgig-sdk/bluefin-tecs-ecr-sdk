package core

import (
	"sync"
)

// MakeConfig builds a fresh, fully materialised config map. Every call
// rebuilds the whole structure, so prefer SharedConfig unless you need a
// private copy you intend to mutate.
func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "BluefinTecsEcr",
		},
		"feature": map[string]any{
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
			},
		},
		"options": map[string]any{
			"base": "https://test.tecs.at/tecsclientrest-auth",
			"auth": map[string]any{
				"prefix": "Bearer",
			},
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"ecr_api": map[string]any{},
			},
		},
		"entity": map[string]any{
			"ecr_api": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "amount",
						"req": true,
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "authorization_number",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "card_number",
						"req": true,
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "currency",
						"req": true,
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "cvc2",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "desired_currency",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "ecr_data",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "language",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "message_type",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "password",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "payment_reason",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "payment_reasonAsByte",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "personal_id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "receipt_layout",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "receipt_number",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "terminal_number",
						"req": true,
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_date_time",
						"req": true,
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_id",
						"req": true,
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_origin_identifier",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_origin_indicator",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_place",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_source_id",
						"type": "`$STRING`",
					},
				},
				"name": "ecr_api",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/makeTransaction",
								"parts": []any{
									"makeTransaction",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/version",
								"parts": []any{
									"version",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
		},
	}
}

var (
	sharedConfigOnce sync.Once
	sharedConfigVal  map[string]any
)

// SharedConfig returns the process-wide config, built once on first use.
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client.
//
// The returned map is shared: treat it as read-only. Callers that need to
// mutate should use MakeConfig, which always returns a fresh copy.
func SharedConfig() map[string]any {
	sharedConfigOnce.Do(func() {
		sharedConfigVal = MakeConfig()
	})
	return sharedConfigVal
}

func makeFeature(name string) Feature {
	switch name {
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
