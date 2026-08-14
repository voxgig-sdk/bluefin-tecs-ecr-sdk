# BluefinTecsEcr SDK configuration

module BluefinTecsEcrConfig
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "BluefinTecsEcr",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
        },
      },
      "options" => {
        "base" => "https://test.tecs.at/tecsclientrest-auth",
        "auth" => {
          "prefix" => "Bearer",
        },
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "ecr_api" => {},
        },
      },
      "entity" => {
        "ecr_api" => {
          "fields" => [
            {
              "name" => "amount",
              "req" => true,
              "type" => "`$STRING`",
            },
            {
              "name" => "authorization_number",
              "type" => "`$STRING`",
            },
            {
              "name" => "card_number",
              "req" => true,
              "type" => "`$STRING`",
            },
            {
              "name" => "currency",
              "req" => true,
              "type" => "`$STRING`",
            },
            {
              "name" => "cvc2",
              "type" => "`$STRING`",
            },
            {
              "name" => "desired_currency",
              "type" => "`$STRING`",
            },
            {
              "name" => "ecr_data",
              "type" => "`$STRING`",
            },
            {
              "name" => "language",
              "type" => "`$STRING`",
            },
            {
              "name" => "message_type",
              "type" => "`$STRING`",
            },
            {
              "name" => "password",
              "type" => "`$STRING`",
            },
            {
              "name" => "payment_reason",
              "type" => "`$STRING`",
            },
            {
              "name" => "payment_reasonAsByte",
              "type" => "`$ARRAY`",
            },
            {
              "name" => "personal_id",
              "type" => "`$STRING`",
            },
            {
              "name" => "receipt_layout",
              "type" => "`$STRING`",
            },
            {
              "name" => "receipt_number",
              "type" => "`$STRING`",
            },
            {
              "name" => "terminal_number",
              "req" => true,
              "type" => "`$STRING`",
            },
            {
              "name" => "transaction_date_time",
              "req" => true,
              "type" => "`$STRING`",
            },
            {
              "name" => "transaction_id",
              "req" => true,
              "type" => "`$STRING`",
            },
            {
              "name" => "transaction_origin_identifier",
              "type" => "`$STRING`",
            },
            {
              "name" => "transaction_origin_indicator",
              "type" => "`$STRING`",
            },
            {
              "name" => "transaction_place",
              "type" => "`$STRING`",
            },
            {
              "name" => "transaction_source_id",
              "type" => "`$STRING`",
            },
          ],
          "name" => "ecr_api",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/makeTransaction",
                  "parts" => [
                    "makeTransaction",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/version",
                  "parts" => [
                    "version",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    BluefinTecsEcrFeatures.make_feature(name)
  end
end
