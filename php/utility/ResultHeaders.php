<?php
declare(strict_types=1);

// BluefinTecsEcr SDK utility: result_headers

class BluefinTecsEcrResultHeaders
{
    public static function call(BluefinTecsEcrContext $ctx): ?BluefinTecsEcrResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
