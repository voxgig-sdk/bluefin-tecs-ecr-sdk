<?php
declare(strict_types=1);

// BluefinTecsEcr SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class BluefinTecsEcrFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new BluefinTecsEcrBaseFeature();
            case "test":
                return new BluefinTecsEcrTestFeature();
            default:
                return new BluefinTecsEcrBaseFeature();
        }
    }
}
