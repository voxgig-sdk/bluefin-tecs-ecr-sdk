<?php
declare(strict_types=1);

// BluefinTecsEcr SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class BluefinTecsEcrMakeContext
{
    public static function call(array $ctxmap, ?BluefinTecsEcrContext $basectx): BluefinTecsEcrContext
    {
        return new BluefinTecsEcrContext($ctxmap, $basectx);
    }
}
