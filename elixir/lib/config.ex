# BluefinTecsEcr SDK configuration
#
# Returns the resolved SDK config as vendored-struct nodes (via
# BluefinTecsEcr.Helpers.deep/1). Do not edit by hand.

defmodule BluefinTecsEcr.Config do
  def make_config do
    BluefinTecsEcr.Helpers.deep(%{
      "main" => %{"name" => "BluefinTecsEcr"},
      "feature" => %{
        "test" => %{
          "options" => %{
            "active" => false
          }
        },
      },
      "options" => %{
        "base" => "https://test.tecs.at/tecsclientrest-auth",
        "auth" => %{"prefix" => "Bearer"},
        "headers" => %{
          "content-type" => "application/json"
        },
        "entity" => %{
          "ecr_api" => %{},
        }
      },
      "entity" => %{
        "ecr_api" => %{
          "fields" => [
            %{
              "active" => true,
              "name" => "amount",
              "req" => true,
              "type" => "`$STRING`",
              "index$" => 0
            },
            %{
              "active" => true,
              "name" => "authorization_number",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 1
            },
            %{
              "active" => true,
              "name" => "card_number",
              "req" => true,
              "type" => "`$STRING`",
              "index$" => 2
            },
            %{
              "active" => true,
              "name" => "currency",
              "req" => true,
              "type" => "`$STRING`",
              "index$" => 3
            },
            %{
              "active" => true,
              "name" => "cvc2",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 4
            },
            %{
              "active" => true,
              "name" => "desired_currency",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 5
            },
            %{
              "active" => true,
              "name" => "ecr_data",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 6
            },
            %{
              "active" => true,
              "name" => "language",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 7
            },
            %{
              "active" => true,
              "name" => "message_type",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 8
            },
            %{
              "active" => true,
              "name" => "password",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 9
            },
            %{
              "active" => true,
              "name" => "payment_reason",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 10
            },
            %{
              "active" => true,
              "name" => "payment_reasonAsByte",
              "req" => false,
              "type" => "`$ARRAY`",
              "index$" => 11
            },
            %{
              "active" => true,
              "name" => "personal_id",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 12
            },
            %{
              "active" => true,
              "name" => "receipt_layout",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 13
            },
            %{
              "active" => true,
              "name" => "receipt_number",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 14
            },
            %{
              "active" => true,
              "name" => "terminal_number",
              "req" => true,
              "type" => "`$STRING`",
              "index$" => 15
            },
            %{
              "active" => true,
              "name" => "transaction_date_time",
              "req" => true,
              "type" => "`$STRING`",
              "index$" => 16
            },
            %{
              "active" => true,
              "name" => "transaction_id",
              "req" => true,
              "type" => "`$STRING`",
              "index$" => 17
            },
            %{
              "active" => true,
              "name" => "transaction_origin_identifier",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 18
            },
            %{
              "active" => true,
              "name" => "transaction_origin_indicator",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 19
            },
            %{
              "active" => true,
              "name" => "transaction_place",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 20
            },
            %{
              "active" => true,
              "name" => "transaction_source_id",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 21
            }
          ],
          "name" => "ecr_api",
          "op" => %{
            "create" => %{
              "input" => "data",
              "name" => "create",
              "points" => [
                %{
                  "active" => true,
                  "args" => %{},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/makeTransaction",
                  "parts" => [
                    "makeTransaction"
                  ],
                  "select" => %{},
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  },
                  "index$" => 0
                }
              ],
              "key$" => "create"
            },
            "load" => %{
              "input" => "data",
              "name" => "load",
              "points" => [
                %{
                  "active" => true,
                  "args" => %{},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/version",
                  "parts" => [
                    "version"
                  ],
                  "select" => %{},
                  "transform" => %{
                    "req" => "`reqdata`",
                    "res" => "`body`"
                  },
                  "index$" => 0
                }
              ],
              "key$" => "load"
            }
          },
          "relations" => %{
            "ancestors" => []
          }
        }
      }
    })
  end
end
