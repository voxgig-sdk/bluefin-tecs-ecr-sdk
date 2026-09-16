# BluefinTecsEcr SDK configuration


# The sekreto plugin DEFINITIONS the model selected per feature, imported
# above by name from the modules the catalogue's active `plugin.def`
# entries declare. Handed to each feature (secrets builds its Sekreto
# with them): a provider kind not listed here is unknown to that SDK.
FEATURE_PLUGINS = {
}


_shared_config = None


def shared_config():
    """Return the process-wide config, built once on first use.

    The SDK reads the config on every request and never writes to it, so one
    instance is shared by every client rather than rebuilt per client.

    The returned dict is shared: treat it as read-only. Callers that need to
    mutate should use make_config, which always returns a fresh copy.
    """
    global _shared_config
    if _shared_config is None:
        _shared_config = make_config()
    return _shared_config


def make_config():
    """Build a fresh, fully materialised config dict.

    Every call rebuilds the whole structure, so prefer shared_config unless
    you need a private copy you intend to mutate.
    """
    return {
        "main": {
            "name": "BluefinTecsEcr",
            "slug": "bluefin-tecs-ecr",
            "version": "0.1.1",
            "target": "py",
        },
        "feature": {
            "audit": {
        "options": {
          "active": False,
          "actor": "anonymous",
          "max": 1000,
        },
        "optspec": {
          "now": "`$FUNCTION`",
          "sink": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "clienttrack": {
        "options": {
          "active": False,
          "clientVersion": "0.0.1",
        },
        "optspec": {
          "clientName": "`$STRING`",
          "clientVersion": "`$STRING`",
          "headers": "`$MAP`",
          "idgen": "`$FUNCTION`",
          "sessionId": "`$STRING`",
        },
        "strict": False,
        "transport": "none",
      },
            "debug": {
        "options": {
          "active": False,
          "max": 100,
          "redact": [
            "authorization",
            "cookie",
            "set-cookie",
            "api-key",
            "apikey",
            "x-api-key",
            "idempotency-key",
          ],
        },
        "optspec": {
          "now": "`$FUNCTION`",
          "onEntry": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "idempotency": {
        "options": {
          "active": False,
          "header": "Idempotency-Key",
          "methods": [
            "POST",
            "PUT",
            "PATCH",
            "DELETE",
          ],
          "ops": [
            "create",
            "update",
            "remove",
          ],
        },
        "optspec": {
          "keygen": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "log": {
        "options": {
          "active": True,
        },
        "optspec": {
          "level": "`$STRING`",
          "logger": "`$ANY`",
        },
        "strict": False,
        "transport": "none",
      },
            "metrics": {
        "options": {
          "active": False,
        },
        "optspec": {
          "now": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "paging": {
        "options": {
          "active": False,
          "afterVar": "after",
          "cursorParam": "cursor",
          "firstVar": "first",
          "limitParam": "limit",
          "pageParam": "page",
          "startPage": 1,
        },
        "optspec": {
          "limit": "`$NUMBER`",
          "ops": "`$LIST`",
        },
        "strict": False,
        "transport": "none",
      },
            "ratelimit": {
        "options": {
          "active": False,
          "burst": 5,
          "rate": 5,
        },
        "optspec": {
          "now": "`$FUNCTION`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "retry": {
        "options": {
          "active": False,
          "factor": 2,
          "maxDelay": 2000,
          "minDelay": 50,
          "retries": 2,
          "statuses": [
            408,
            425,
            429,
            500,
            502,
            503,
            504,
          ],
        },
        "optspec": {
          "jitter": "`$BOOLEAN`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "telemetry": {
        "options": {
          "active": False,
        },
        "optspec": {
          "exporter": "`$FUNCTION`",
          "headers": "`$MAP`",
          "idgen": "`$FUNCTION`",
          "now": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "none",
      },
            "test": {
        "options": {
          "active": False,
        },
        "optspec": {
          "entity": "`$MAP`",
          "net": "`$MAP`",
        },
        "strict": False,
        "transport": "base",
      },
            "timeout": {
        "options": {
          "active": False,
          "ms": 30000,
        },
        "optspec": {
          "clearTimer": "`$FUNCTION`",
          "setTimer": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
        },
        "options": {
            "base": "https://test.tecs.at/tecsclientrest-auth",
            "auth": {
                "prefix": "Bearer",
            },
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "ecr_api": {},
            },
        },
        "entity": {
      "ecr_api": {
        "fields": [
          {
            "name": "amount",
            "req": True,
            "short": "Numeric Transaction Amount.",
            "type": "`$STRING`",
          },
          {
            "name": "authorization_number",
            "short": "For Gratuity (msg type 0009): the authorization number of the original transaction.",
            "type": "`$STRING`",
          },
          {
            "name": "card_number",
            "req": True,
            "short": "Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty.",
            "type": "`$STRING`",
          },
          {
            "name": "currency",
            "req": True,
            "short": "ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\").",
            "type": "`$STRING`",
          },
          {
            "name": "cvc2",
            "short": "Card Verification Code.",
            "type": "`$STRING`",
          },
          {
            "name": "desired_currency",
            "short": "ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\").",
            "type": "`$STRING`",
          },
          {
            "name": "ecr_data",
            "short": "ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).",
            "type": "`$STRING`",
          },
          {
            "name": "language",
            "short": "ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\").",
            "type": "`$STRING`",
          },
          {
            "name": "message_type",
            "short": "Message type code.",
            "type": "`$STRING`",
          },
          {
            "name": "password",
            "short": "Password - currently not used (filled with spaces).",
            "type": "`$STRING`",
          },
          {
            "name": "payment_reason",
            "short": "Payment reason (e.g., \"Taxi journey\").",
            "type": "`$STRING`",
          },
          {
            "name": "payment_reasonAsByte",
            "short": "Payment reason represented as a byte array.",
            "type": "`$ARRAY`",
          },
          {
            "name": "personal_id",
            "short": "Identification of the current user of the ECR or Terminal.",
            "type": "`$STRING`",
          },
          {
            "name": "receipt_layout",
            "short": "Receipt layout identifier.",
            "type": "`$STRING`",
          },
          {
            "name": "receipt_number",
            "short": "Receipt number.",
            "type": "`$STRING`",
          },
          {
            "name": "terminal_number",
            "req": True,
            "short": "Terminal number provided by TECS.",
            "type": "`$STRING`",
          },
          {
            "name": "transaction_date_time",
            "req": True,
            "short": "Transaction date and time (format: yyyymmddhhmmss).",
            "type": "`$STRING`",
          },
          {
            "name": "transaction_id",
            "req": True,
            "short": "Unique transaction identifier.",
            "type": "`$STRING`",
          },
          {
            "name": "transaction_origin_identifier",
            "short": "Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance",
            "type": "`$STRING`",
          },
          {
            "name": "transaction_origin_indicator",
            "short": "Transaction origin indicator: - 0 = Request for card data on PIN PAD.",
            "type": "`$STRING`",
          },
          {
            "name": "transaction_place",
            "short": "The transaction place; the first 5 characters should contain a formatted zip code.",
            "type": "`$STRING`",
          },
          {
            "name": "transaction_source_id",
            "short": "Identification number of the authorization source.",
            "type": "`$STRING`",
          },
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
                "segments": [
                  {
                    "lit": "makeTransaction",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "makeTransaction",
                ],
              },
            ],
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
                "segments": [
                  {
                    "lit": "version",
                  },
                ],
                "select": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "parts": [
                  "version",
                ],
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
