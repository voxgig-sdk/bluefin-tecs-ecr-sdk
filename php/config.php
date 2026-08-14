<?php
declare(strict_types=1);

// BluefinTecsEcr SDK configuration

class BluefinTecsEcrConfig
{
    /** @var array<string,mixed>|null */
    private static ?array $shared_config = null;

    /**
     * Return the process-wide config, built once on first use. The SDK reads
     * the config on every request and never writes to it, so one instance is
     * shared by every client rather than rebuilt per client.
     *
     * PHP arrays are copy-on-write, so callers that do mutate the result get
     * their own copy and cannot disturb the shared one.
     */
    public static function shared_config(): array
    {
        if (self::$shared_config === null) {
            self::$shared_config = self::make_config();
        }
        return self::$shared_config;
    }

    /**
     * Build a fresh, fully materialised config array. Every call rebuilds the
     * whole structure, so prefer shared_config unless you need a private copy.
     */
    public static function make_config(): array
    {
        return [
            "main" => [
                "name" => "BluefinTecsEcr",
            ],
            "feature" => [
                "test" => [
          'options' => [
            'active' => false,
          ],
        ],
            ],
            "options" => [
                "base" => "https://test.tecs.at/tecsclientrest-auth",
                "auth" => [
                    "prefix" => "Bearer",
                ],
                "headers" => [
          'content-type' => 'application/json',
        ],
                "entity" => [
                    "ecr_api" => [],
                ],
            ],
            "entity" => [
        'ecr_api' => [
          'fields' => [
            [
              'name' => 'amount',
              'req' => true,
              'type' => '`$STRING`',
            ],
            [
              'name' => 'authorization_number',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'card_number',
              'req' => true,
              'type' => '`$STRING`',
            ],
            [
              'name' => 'currency',
              'req' => true,
              'type' => '`$STRING`',
            ],
            [
              'name' => 'cvc2',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'desired_currency',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'ecr_data',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'language',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'message_type',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'password',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'payment_reason',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'payment_reasonAsByte',
              'type' => '`$ARRAY`',
            ],
            [
              'name' => 'personal_id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'receipt_layout',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'receipt_number',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'terminal_number',
              'req' => true,
              'type' => '`$STRING`',
            ],
            [
              'name' => 'transaction_date_time',
              'req' => true,
              'type' => '`$STRING`',
            ],
            [
              'name' => 'transaction_id',
              'req' => true,
              'type' => '`$STRING`',
            ],
            [
              'name' => 'transaction_origin_identifier',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'transaction_origin_indicator',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'transaction_place',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'transaction_source_id',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'ecr_api',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'POST',
                  'orig' => '/makeTransaction',
                  'parts' => [
                    'makeTransaction',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/version',
                  'parts' => [
                    'version',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
      ],
        ];
    }


    public static function make_feature(string $name)
    {
        require_once __DIR__ . '/features.php';
        return BluefinTecsEcrFeatures::make_feature($name);
    }
}
