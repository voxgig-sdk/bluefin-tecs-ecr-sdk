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
			"slug": "bluefin-tecs-ecr",
			"version": "0.0.1",
			"target": "go",
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
						"short": "Numeric Transaction Amount.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "authorization_number",
						"short": "For Gratuity (msg type 0009): the authorization number of the original transaction.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "card_number",
						"req": true,
						"short": "Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "currency",
						"req": true,
						"short": "ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\").",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "cvc2",
						"short": "Card Verification Code.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "desired_currency",
						"short": "ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\").",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "ecr_data",
						"short": "ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "language",
						"short": "ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\").",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "message_type",
						"short": "Message type code.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "password",
						"short": "Password - currently not used (filled with spaces).",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "payment_reason",
						"short": "Payment reason (e.g., \"Taxi journey\").",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "payment_reasonAsByte",
						"short": "Payment reason represented as a byte array.",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "personal_id",
						"short": "Identification of the current user of the ECR or Terminal.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "receipt_layout",
						"short": "Receipt layout identifier.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "receipt_number",
						"short": "Receipt number.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "terminal_number",
						"req": true,
						"short": "Terminal number provided by TECS.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_date_time",
						"req": true,
						"short": "Transaction date and time (format: yyyymmddhhmmss).",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_id",
						"req": true,
						"short": "Unique transaction identifier.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_origin_identifier",
						"short": "Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_origin_indicator",
						"short": "Transaction origin indicator: - 0 = Request for card data on PIN PAD.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_place",
						"short": "The transaction place; the first 5 characters should contain a formatted zip code.",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "transaction_source_id",
						"short": "Identification number of the authorization source.",
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
