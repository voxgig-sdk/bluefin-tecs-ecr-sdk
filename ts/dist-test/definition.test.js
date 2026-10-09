"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const node_test_1 = require("node:test");
const __1 = require("..");
const definition_runner_1 = require("./definition-runner");
const utility_1 = require("./utility");
// Generated from the API definition, not from the model this SDK was built
// from: the route, the declared query parameters, the credential the security
// scheme names, and the definition's own response example.
const PLAN = [
    {
        "entity": "ecr_api",
        "accessor": "EcrApi",
        "op": "create",
        "method": "POST",
        "path": "/makeTransaction",
        "args": [],
        "select": {},
        "headers": [],
        "cookies": [],
        "responseMedia": [
            "*/*"
        ],
        "query": [],
        "queryArgs": [],
        "auth": [
            [
                {
                    "in": "header",
                    "name": "authorization",
                    "scheme": "bearer"
                }
            ]
        ],
        "status": 200,
        "sample": {
            "authorization_number": "x",
            "balance_amount": "x",
            "bonus_point": "x",
            "card_number": "x",
            "credit_card_issuer_and_acquirer_company": "x",
            "ecr_data": "x",
            "ex_fee": "x",
            "exchange_rate": "x",
            "foreign_tx_amount": "x",
            "merchant_address": "x",
            "merchant_name": "x",
            "message_type": "x",
            "operator_id": "x",
            "orig_stan": "x",
            "orig_tx_id": "x",
            "receipt_footer": "x",
            "receipt_header": "x",
            "response_code": "x",
            "response_text": "x",
            "serien_nr": "x",
            "stan": "x",
            "svc": "x",
            "transaction_date_time": "x",
            "transaction_id": "x",
            "transaction_type": "x",
            "vu_number": "x"
        },
        "idField": "id"
    },
    {
        "entity": "ecr_api",
        "accessor": "EcrApi",
        "op": "load",
        "method": "GET",
        "path": "/version",
        "args": [],
        "select": {},
        "headers": [],
        "cookies": [],
        "responseMedia": [
            "*/*"
        ],
        "query": [],
        "queryArgs": [],
        "auth": [],
        "status": 200,
        "sample": {
            "appName": "x",
            "version": "x",
            "buildDate": "x"
        },
        "idField": "id"
    }
];
(0, node_test_1.describe)('definition', () => {
    for (const point of PLAN) {
        (0, node_test_1.test)(point.entity + '.' + point.op + ' ' + point.method + ' ' + point.path, async (t) => {
            const control = (0, utility_1.isControlSkipped)('entityOp', point.entity + '.' + point.op, 'definition');
            if (control.skip) {
                t.skip(control.reason || 'skipped via sdk-test-control.json');
                return;
            }
            await (0, definition_runner_1.runDefinitionPoint)(__1.SDK, point);
        });
    }
});
//# sourceMappingURL=definition.test.js.map