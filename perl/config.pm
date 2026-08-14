# BluefinTecsEcr SDK configuration

use strict;
use warnings;

use File::Basename ();
use Cwd ();

my $__dir;
BEGIN { $__dir = File::Basename::dirname(Cwd::abs_path(__FILE__)) }
require(Cwd::abs_path("$__dir/lib/Voxgig/Struct.pm"));

package BluefinTecsEcrConfig;

# GENERATED from the API model - do not edit by hand. Parsed fresh on
# each call so callers can safely mutate their copy.
my $CONFIG_JSON = <<'END_CONFIG_JSON';
{
  "main": {
    "name": "BluefinTecsEcr"
  },
  "feature": {
    "test": {
      "options": {
        "active": false
      }
    }
  },
  "options": {
    "base": "https://test.tecs.at/tecsclientrest-auth",
    "auth": {
      "prefix": "Bearer"
    },
    "headers": {
      "content-type": "application/json"
    },
    "entity": {
      "ecr_api": {}
    }
  },
  "entity": {
    "ecr_api": {
      "fields": [
        {
          "name": "amount",
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "authorization_number",
          "type": "`$STRING`"
        },
        {
          "name": "card_number",
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "currency",
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "cvc2",
          "type": "`$STRING`"
        },
        {
          "name": "desired_currency",
          "type": "`$STRING`"
        },
        {
          "name": "ecr_data",
          "type": "`$STRING`"
        },
        {
          "name": "language",
          "type": "`$STRING`"
        },
        {
          "name": "message_type",
          "type": "`$STRING`"
        },
        {
          "name": "password",
          "type": "`$STRING`"
        },
        {
          "name": "payment_reason",
          "type": "`$STRING`"
        },
        {
          "name": "payment_reasonAsByte",
          "type": "`$ARRAY`"
        },
        {
          "name": "personal_id",
          "type": "`$STRING`"
        },
        {
          "name": "receipt_layout",
          "type": "`$STRING`"
        },
        {
          "name": "receipt_number",
          "type": "`$STRING`"
        },
        {
          "name": "terminal_number",
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "transaction_date_time",
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "transaction_id",
          "req": true,
          "type": "`$STRING`"
        },
        {
          "name": "transaction_origin_identifier",
          "type": "`$STRING`"
        },
        {
          "name": "transaction_origin_indicator",
          "type": "`$STRING`"
        },
        {
          "name": "transaction_place",
          "type": "`$STRING`"
        },
        {
          "name": "transaction_source_id",
          "type": "`$STRING`"
        }
      ],
      "name": "ecr_api",
      "op": {
        "create": {
          "input": "data",
          "name": "create",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "POST",
              "orig": "/makeTransaction",
              "parts": [
                "makeTransaction"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {},
              "kind": "http",
              "method": "GET",
              "orig": "/version",
              "parts": [
                "version"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    }
  }
}
END_CONFIG_JSON

sub make_config {
  return Voxgig::Struct::parse_json($CONFIG_JSON);
}

sub make_feature {
  my ($name) = @_;
  require(Cwd::abs_path("$__dir/features.pm"));
  return BluefinTecsEcrFeatures::make_feature($name);
}

1;
