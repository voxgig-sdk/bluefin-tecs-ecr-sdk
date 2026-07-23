<?php
declare(strict_types=1);

// BluefinTecsEcr SDK exists test

require_once __DIR__ . '/../bluefintecsecr_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = BluefinTecsEcrSDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
