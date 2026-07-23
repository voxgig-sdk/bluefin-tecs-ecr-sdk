<?php
declare(strict_types=1);

// BluefinTecsEcr SDK utility: prepare_body

class BluefinTecsEcrPrepareBody
{
    public static function call(BluefinTecsEcrContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
