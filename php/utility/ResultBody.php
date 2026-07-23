<?php
declare(strict_types=1);

// BluefinTecsEcr SDK utility: result_body

class BluefinTecsEcrResultBody
{
    public static function call(BluefinTecsEcrContext $ctx): ?BluefinTecsEcrResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
