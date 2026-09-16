
const envlocal = __dirname + '/../../../.env.local'
require('../../utility').loadEnvLocal(envlocal)

const Path = require('node:path')
const Fs = require('node:fs')

const { test, describe, afterEach } = require('node:test')
const assert = require('node:assert')
const { createLiveTransport } = require('../../live-runner')
const { runLiveEntity } = require('../../live-entity')


const { BluefinTecsEcrSDK, BaseFeature, stdutil, config } = require('../../..')

const {
  envOverride,
  liveClientOptions,
  liveDelay,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
} = require('../../utility')


describe('EcrApiEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when BLUEFIN_TECS_ECR_TEST_LIVE=TRUE.
  afterEach(liveDelay('BLUEFIN_TECS_ECR_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = BluefinTecsEcrSDK.test()
    const ent = testsdk.EcrApi()
    assert(null != ent)
  })


  test('basic', async (t) => {

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"name":"amount","req":true,"short":"Numeric Transaction Amount.","type":"`$STRING`","index$":0},{"active":true,"name":"authorization_number","req":false,"short":"For Gratuity (msg type 0009): the authorization number of the original transaction.","type":"`$STRING`","index$":1},{"active":true,"name":"card_number","req":true,"short":"Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty.","type":"`$STRING`","index$":2},{"active":true,"name":"currency","req":true,"short":"ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\").","type":"`$STRING`","index$":3},{"active":true,"name":"cvc2","req":false,"short":"Card Verification Code.","type":"`$STRING`","index$":4},{"active":true,"name":"desired_currency","req":false,"short":"ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\").","type":"`$STRING`","index$":5},{"active":true,"name":"ecr_data","req":false,"short":"ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).","type":"`$STRING`","index$":6},{"active":true,"name":"language","req":false,"short":"ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\").","type":"`$STRING`","index$":7},{"active":true,"name":"message_type","req":false,"short":"Message type code.","type":"`$STRING`","index$":8},{"active":true,"name":"password","req":false,"short":"Password - currently not used (filled with spaces).","type":"`$STRING`","index$":9},{"active":true,"name":"payment_reason","req":false,"short":"Payment reason (e.g., \"Taxi journey\").","type":"`$STRING`","index$":10},{"active":true,"name":"payment_reasonAsByte","req":false,"short":"Payment reason represented as a byte array.","type":"`$ARRAY`","index$":11},{"active":true,"name":"personal_id","req":false,"short":"Identification of the current user of the ECR or Terminal.","type":"`$STRING`","index$":12},{"active":true,"name":"receipt_layout","req":false,"short":"Receipt layout identifier.","type":"`$STRING`","index$":13},{"active":true,"name":"receipt_number","req":false,"short":"Receipt number.","type":"`$STRING`","index$":14},{"active":true,"name":"terminal_number","req":true,"short":"Terminal number provided by TECS.","type":"`$STRING`","index$":15},{"active":true,"name":"transaction_date_time","req":true,"short":"Transaction date and time (format: yyyymmddhhmmss).","type":"`$STRING`","index$":16},{"active":true,"name":"transaction_id","req":true,"short":"Unique transaction identifier.","type":"`$STRING`","index$":17},{"active":true,"name":"transaction_origin_identifier","req":false,"short":"Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance","type":"`$STRING`","index$":18},{"active":true,"name":"transaction_origin_indicator","req":false,"short":"Transaction origin indicator: - 0 = Request for card data on PIN PAD.","type":"`$STRING`","index$":19},{"active":true,"name":"transaction_place","req":false,"short":"The transaction place; the first 5 characters should contain a formatted zip code.","type":"`$STRING`","index$":20},{"active":true,"name":"transaction_source_id","req":false,"short":"Identification number of the authorization source.","type":"`$STRING`","index$":21}],"name":"ecr_api","op":{"create":{"input":"data","name":"create","points":[{"active":true,"args":{},"contract":{"id":"POST /makeTransaction","json":"{\"operationId\":\"makeTransaction\",\"parameters\":[],\"protocol\":\"http\",\"requestBody\":{\"content\":{\"application/json\":{\"schema\":{\"description\":\"Request properties for processing a transaction.\",\"properties\":{\"amount\":{\"description\":\"Numeric Transaction Amount. According to the ISO 4217 currency exponent, for example:\\n- EUR (exponent = 2): 12,55 EUR is represented as \\\"1255\\\"\\n- BYR (exponent = 0): 15000 BYR is represented as \\\"15000\\\"\\n\",\"example\":\"1255\",\"maxLength\":11,\"type\":\"string\"},\"authorization_number\":{\"description\":\"For Gratuity (msg type 0009): the authorization number of the original transaction.\\nOtherwise, leave this field empty.\\n\",\"maxLength\":9,\"type\":\"string\"},\"card_number\":{\"description\":\"Depends on the transaction scenario:\\n- **Standard Pin Pad transaction:** leave empty.\\n- **Manual PAN input:** provide card number + \\\"_\\\" + expiration date (YYMM).\\n- **Swiped card on ECR:** include Track2 data.\\n- **Cancellation/Capture (msg type 0013):** \\\"TXID\\\" + original transaction number.\\n- **Gratuity (msg type 0009) or Credit note (msg type 0011):** \\\"TXID\\\" + original transaction number.\\n- **Cancellation/Capture from different terminal:** \\\"TXID\\\" + \\\"_\\\" + \\\"_\\\" (e.g., \\\"TXID00000000001234567890_01_88091234\\\").\\n\",\"example\":\"TXID00000000001234567890\",\"maxLength\":40,\"type\":\"string\"},\"currency\":{\"description\":\"ISO 4217 Alpha Currency Code (e.g., \\\"EUR\\\", \\\"USD\\\").\\n\",\"example\":\"EUR\",\"maxLength\":3,\"minLength\":3,\"type\":\"string\"},\"cvc2\":{\"description\":\"Card Verification Code.\\n\",\"example\":\"123\",\"maxLength\":4,\"type\":\"string\"},\"desired_currency\":{\"description\":\"ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \\\"EUR\\\", \\\"USD\\\").\\n\",\"example\":\"USD\",\"maxLength\":3,\"type\":\"string\"},\"ecr_data\":{\"description\":\"ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).\\nThis field is sent as received.\\n\",\"example\":\"ECR123\",\"maxLength\":250,\"type\":\"string\"},\"language\":{\"description\":\"ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \\\"en\\\", \\\"de\\\", \\\"es\\\").\\n\",\"example\":\"en\",\"maxLength\":2,\"type\":\"string\"},\"message_type\":{\"description\":\"Message type code. Allowed values include:\\n- 0001 = Purchase, Balance, or Preauthorization\\n- 0005 = Purchase with authorization number\\n- 0009 = Gratuity\\n- 0011 = Credit note\\n- 0013 = Cancellation/Capture\\n- 0015 = Pre-paid (Mobile Recharge)\\n- 0017 = Abort ongoing transaction\\n- 0018 = External reader device restart command\\n- 0027 = Voucher/Coupon generation\\n- 0029 = Card to Card transfer\\n- 0034 = End of day (Internal TC only)\\n- 2667 = Get connection status (Internal TC only)\\n- 2668 = Terminal send diagnostic message (Internal TC only)\\n- 4544 = Kill application (Internal TC only)\\n- 9043 = Get terminal status\\n- 9999 = Initiate CTLS tap event simulator\\n- 7976 = Pops-up terminal system menu (Internal TC only)\\n\",\"example\":\"0001\",\"maxLength\":4,\"minLength\":4,\"type\":\"string\"},\"password\":{\"description\":\"Password - currently not used (filled with spaces).\\n\",\"example\":\"        \",\"maxLength\":8,\"type\":\"string\"},\"payment_reason\":{\"description\":\"Payment reason (e.g., \\\"Taxi journey\\\"). Should be agreed with the acquirer.\\nFor Prepaid/Mobile recharge (msg type 0015): \\\"+\\\" followed by Operator Code and optional phone number.\\n(UTF-8 encoded; maximum binary size is 39 bytes.)\\n\",\"example\":\"Taxi journey\",\"maxLength\":39,\"type\":\"string\"},\"payment_reasonAsByte\":{\"description\":\"Payment reason represented as a byte array.\\n\",\"example\":[\"0x54\",\"0x61\",\"0x78\",\"0x69\"],\"items\":{\"format\":\"byte\",\"type\":\"string\"},\"type\":\"array\"},\"personal_id\":{\"description\":\"Identification of the current user of the ECR or Terminal.\\n\",\"example\":\"User123\",\"maxLength\":50,\"type\":\"string\"},\"receipt_layout\":{\"description\":\"Receipt layout identifier.\\n\",\"example\":\"01\",\"maxLength\":2,\"type\":\"string\"},\"receipt_number\":{\"description\":\"Receipt number.\\n\",\"example\":\"0123\",\"maxLength\":20,\"type\":\"string\"},\"terminal_number\":{\"description\":\"Terminal number provided by TECS. For Cancellation/Capture (msg type 0013),\\nthis is the terminal number of the original transaction.\\n\",\"example\":\"88091105\",\"maxLength\":8,\"minLength\":8,\"type\":\"string\"},\"transaction_date_time\":{\"description\":\"Transaction date and time (format: yyyymmddhhmmss).\\n\",\"example\":\"20240430123045\",\"pattern\":\"^[0-9]{14}$\",\"type\":\"string\"},\"transaction_id\":{\"description\":\"Unique transaction identifier. Must be unique for every transaction performed on the specified Terminal.\\n\",\"example\":\"TX1234567890\",\"maxLength\":20,\"type\":\"string\"},\"transaction_origin_identifier\":{\"description\":\"Transaction origin identifier:\\n- 1 = Face to Face (Customer present)\\n- 2 = MOTO (Customer not present)\\n- 4 = Capture/Completion\\n- 5 = Pre Authorization\\n- 7 = Balance\\n\",\"example\":\"1\",\"maxLength\":1,\"minLength\":1,\"type\":\"string\"},\"transaction_origin_indicator\":{\"description\":\"Transaction origin indicator:\\n- 0 = Request for card data on PIN PAD.\\n- 1 = Face to Face (Magswipe on ECR, no PIN PAD).\\n- 2 = Mail order/Telephone order/Manual entry (no PIN PAD).\\n\",\"example\":\"0\",\"maxLength\":1,\"type\":\"string\"},\"transaction_place\":{\"description\":\"The transaction place; the first 5 characters should contain a formatted zip code.\\n\",\"example\":\"12345\",\"maxLength\":13,\"type\":\"string\"},\"transaction_source_id\":{\"description\":\"Identification number of the authorization source. In cancellation (msg type 0013),\\ngratuity (0009), or credit note (msg type 0011), it should match the original transaction's source ID as provided by TECS.\\n\",\"example\":\"01\",\"maxLength\":2,\"type\":\"string\"}},\"required\":[\"amount\",\"card_number\",\"currency\",\"terminal_number\",\"transaction_date_time\",\"transaction_id\"],\"type\":\"object\"}}},\"required\":true},\"responses\":{\"200\":{\"content\":{\"*/*\":{\"schema\":{\"description\":\"Response properties for a transaction.\",\"properties\":{\"authorization_number\":{\"description\":\"Alphanumeric. Authorization number generated by TECS Authorization Host.\\n\",\"maxLength\":9,\"type\":\"string\"},\"balance_amount\":{\"description\":\"Alphanumeric. Maximum amount available.\\n\",\"maxLength\":20,\"type\":\"string\"},\"bonus_point\":{\"description\":\"Alphanumeric. Actual bonus points.\\n\",\"maxLength\":100,\"type\":\"string\"},\"card_number\":{\"description\":\"Alphanumeric. Depends on the transaction scenario:\\n- Standard transaction: Card number + \\\"_\\\" + expiration date (YYMM).\\n- For terminals activated for Card Reference number: \\\"REF\\\" + reference no + \\\"_\\\" + expiry date (YYMM) + \\\"_\\\" + last 4 digits from PAN + \\\"_\\\" + first 6 digits from PAN.\\n- Cancellation/capture/credit note: \\\"TXID\\\" + transaction number as entered in request.\\n- Non ISO based Card numbers: Card prefix + Card number.\\nCard prefixes are defined by TECS and are stated in the document \\\"NonISO_CardIssuer_Prefixes\\\" provided by TECS.\\n\",\"maxLength\":40,\"type\":\"string\"},\"credit_card_issuer_and_acquirer_company\":{\"description\":\"Alphanumeric. Acquirer name + \\\";\\\" + card brand (e.g. \\\"VISA\\\").\\n\",\"maxLength\":40,\"type\":\"string\"},\"ecr_data\":{\"description\":\"Alphanumeric. ECR Data field used to transfer user information for private labeled cards like Fleet Card Company (e.g. UTA, outex, etc.). This field is sent from TECS Server to ECR as received.\\n\",\"maxLength\":250,\"type\":\"string\"},\"ex_fee\":{\"description\":\"Numeric. Exchange fee.\\n\",\"maxLength\":100,\"type\":\"string\"},\"exchange_rate\":{\"description\":\"Alphanumeric. Exchange rate at the time of transaction (e.g. 000000000000001,1223).\\n\",\"maxLength\":20,\"type\":\"string\"},\"foreign_tx_amount\":{\"description\":\"Alphanumeric. Transaction amount in desired currency.\\n\",\"maxLength\":20,\"type\":\"string\"},\"merchant_address\":{\"description\":\"Alphanumeric. Merchant address.\\n\",\"maxLength\":50,\"type\":\"string\"},\"merchant_name\":{\"description\":\"Alphanumeric. Merchant name.\\n\",\"maxLength\":25,\"type\":\"string\"},\"message_type\":{\"description\":\"Numeric. Message type:\\n0002 = Transaction response.\\n\",\"maxLength\":4,\"type\":\"string\"},\"operator_id\":{\"description\":\"Alphanumeric. Identification of the operator of the TECS engine installation.\\n\",\"maxLength\":12,\"type\":\"string\"},\"orig_stan\":{\"description\":\"Numeric. STAN of original transaction (for Cancellation).\\n\",\"maxLength\":6,\"type\":\"string\"},\"orig_tx_id\":{\"description\":\"Numeric. Original transaction ID (for Cancellation).\\n\",\"maxLength\":20,\"type\":\"string\"},\"receipt_footer\":{\"description\":\"Alphanumeric. Receipt footer that must be printed on the receipt.\\nContains the authentication method (\\\"PIN VERIFIED\\\" or \\\"SIGNATURE\\\") and tags \\\"AID:\\\" and \\\"AC:\\\".\\n\",\"maxLength\":100,\"type\":\"string\"},\"receipt_header\":{\"description\":\"Alphanumeric. Receipt header.\\n\",\"maxLength\":100,\"type\":\"string\"},\"response_code\":{\"description\":\"Numeric. Response code.\\n\",\"maxLength\":4,\"type\":\"string\"},\"response_text\":{\"description\":\"Alphanumeric. Response text - description of the response code.\\nText is UTF-8 encoded. Binary size of the field is 80 bytes.\\n\",\"maxLength\":80,\"type\":\"string\"},\"serien_nr\":{\"description\":\"Alphanumeric. If present, should be printed on the receipt.\\n\",\"maxLength\":9,\"type\":\"string\"},\"stan\":{\"description\":\"Numeric. TECS Trace Number.\\n\",\"maxLength\":6,\"type\":\"string\"},\"svc\":{\"description\":\"Numeric. Service code (returned by TECS Server). Must be printed on the receipt.\\n\",\"maxLength\":3,\"type\":\"string\"},\"transaction_date_time\":{\"description\":\"Numeric. Transaction date and time (format: yyyymmddhhmmss).\\n\",\"maxLength\":14,\"type\":\"string\"},\"transaction_id\":{\"description\":\"Alphanumeric. Transaction unique identifier (should be the same as sent in the authorization request).\\n\",\"maxLength\":20,\"type\":\"string\"},\"transaction_type\":{\"description\":\"Alphanumeric. Transaction type.\\n\",\"maxLength\":2,\"type\":\"string\"},\"vu_number\":{\"description\":\"Alphanumeric. Merchant Contract number with acquirer.\\n\",\"maxLength\":15,\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"successfully routed to TecsClient.\"},\"400\":{\"content\":{\"*/*\":{\"schema\":{\"description\":\"Response properties for a transaction.\",\"properties\":{\"authorization_number\":{\"description\":\"Alphanumeric. Authorization number generated by TECS Authorization Host.\\n\",\"maxLength\":9,\"type\":\"string\"},\"balance_amount\":{\"description\":\"Alphanumeric. Maximum amount available.\\n\",\"maxLength\":20,\"type\":\"string\"},\"bonus_point\":{\"description\":\"Alphanumeric. Actual bonus points.\\n\",\"maxLength\":100,\"type\":\"string\"},\"card_number\":{\"description\":\"Alphanumeric. Depends on the transaction scenario:\\n- Standard transaction: Card number + \\\"_\\\" + expiration date (YYMM).\\n- For terminals activated for Card Reference number: \\\"REF\\\" + reference no + \\\"_\\\" + expiry date (YYMM) + \\\"_\\\" + last 4 digits from PAN + \\\"_\\\" + first 6 digits from PAN.\\n- Cancellation/capture/credit note: \\\"TXID\\\" + transaction number as entered in request.\\n- Non ISO based Card numbers: Card prefix + Card number.\\nCard prefixes are defined by TECS and are stated in the document \\\"NonISO_CardIssuer_Prefixes\\\" provided by TECS.\\n\",\"maxLength\":40,\"type\":\"string\"},\"credit_card_issuer_and_acquirer_company\":{\"description\":\"Alphanumeric. Acquirer name + \\\";\\\" + card brand (e.g. \\\"VISA\\\").\\n\",\"maxLength\":40,\"type\":\"string\"},\"ecr_data\":{\"description\":\"Alphanumeric. ECR Data field used to transfer user information for private labeled cards like Fleet Card Company (e.g. UTA, outex, etc.). This field is sent from TECS Server to ECR as received.\\n\",\"maxLength\":250,\"type\":\"string\"},\"ex_fee\":{\"description\":\"Numeric. Exchange fee.\\n\",\"maxLength\":100,\"type\":\"string\"},\"exchange_rate\":{\"description\":\"Alphanumeric. Exchange rate at the time of transaction (e.g. 000000000000001,1223).\\n\",\"maxLength\":20,\"type\":\"string\"},\"foreign_tx_amount\":{\"description\":\"Alphanumeric. Transaction amount in desired currency.\\n\",\"maxLength\":20,\"type\":\"string\"},\"merchant_address\":{\"description\":\"Alphanumeric. Merchant address.\\n\",\"maxLength\":50,\"type\":\"string\"},\"merchant_name\":{\"description\":\"Alphanumeric. Merchant name.\\n\",\"maxLength\":25,\"type\":\"string\"},\"message_type\":{\"description\":\"Numeric. Message type:\\n0002 = Transaction response.\\n\",\"maxLength\":4,\"type\":\"string\"},\"operator_id\":{\"description\":\"Alphanumeric. Identification of the operator of the TECS engine installation.\\n\",\"maxLength\":12,\"type\":\"string\"},\"orig_stan\":{\"description\":\"Numeric. STAN of original transaction (for Cancellation).\\n\",\"maxLength\":6,\"type\":\"string\"},\"orig_tx_id\":{\"description\":\"Numeric. Original transaction ID (for Cancellation).\\n\",\"maxLength\":20,\"type\":\"string\"},\"receipt_footer\":{\"description\":\"Alphanumeric. Receipt footer that must be printed on the receipt.\\nContains the authentication method (\\\"PIN VERIFIED\\\" or \\\"SIGNATURE\\\") and tags \\\"AID:\\\" and \\\"AC:\\\".\\n\",\"maxLength\":100,\"type\":\"string\"},\"receipt_header\":{\"description\":\"Alphanumeric. Receipt header.\\n\",\"maxLength\":100,\"type\":\"string\"},\"response_code\":{\"description\":\"Numeric. Response code.\\n\",\"maxLength\":4,\"type\":\"string\"},\"response_text\":{\"description\":\"Alphanumeric. Response text - description of the response code.\\nText is UTF-8 encoded. Binary size of the field is 80 bytes.\\n\",\"maxLength\":80,\"type\":\"string\"},\"serien_nr\":{\"description\":\"Alphanumeric. If present, should be printed on the receipt.\\n\",\"maxLength\":9,\"type\":\"string\"},\"stan\":{\"description\":\"Numeric. TECS Trace Number.\\n\",\"maxLength\":6,\"type\":\"string\"},\"svc\":{\"description\":\"Numeric. Service code (returned by TECS Server). Must be printed on the receipt.\\n\",\"maxLength\":3,\"type\":\"string\"},\"transaction_date_time\":{\"description\":\"Numeric. Transaction date and time (format: yyyymmddhhmmss).\\n\",\"maxLength\":14,\"type\":\"string\"},\"transaction_id\":{\"description\":\"Alphanumeric. Transaction unique identifier (should be the same as sent in the authorization request).\\n\",\"maxLength\":20,\"type\":\"string\"},\"transaction_type\":{\"description\":\"Alphanumeric. Transaction type.\\n\",\"maxLength\":2,\"type\":\"string\"},\"vu_number\":{\"description\":\"Alphanumeric. Merchant Contract number with acquirer.\\n\",\"maxLength\":15,\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"some error, explained in responseText\"},\"504\":{\"content\":{\"*/*\":{\"schema\":{\"description\":\"Response properties for a transaction.\",\"properties\":{\"authorization_number\":{\"description\":\"Alphanumeric. Authorization number generated by TECS Authorization Host.\\n\",\"maxLength\":9,\"type\":\"string\"},\"balance_amount\":{\"description\":\"Alphanumeric. Maximum amount available.\\n\",\"maxLength\":20,\"type\":\"string\"},\"bonus_point\":{\"description\":\"Alphanumeric. Actual bonus points.\\n\",\"maxLength\":100,\"type\":\"string\"},\"card_number\":{\"description\":\"Alphanumeric. Depends on the transaction scenario:\\n- Standard transaction: Card number + \\\"_\\\" + expiration date (YYMM).\\n- For terminals activated for Card Reference number: \\\"REF\\\" + reference no + \\\"_\\\" + expiry date (YYMM) + \\\"_\\\" + last 4 digits from PAN + \\\"_\\\" + first 6 digits from PAN.\\n- Cancellation/capture/credit note: \\\"TXID\\\" + transaction number as entered in request.\\n- Non ISO based Card numbers: Card prefix + Card number.\\nCard prefixes are defined by TECS and are stated in the document \\\"NonISO_CardIssuer_Prefixes\\\" provided by TECS.\\n\",\"maxLength\":40,\"type\":\"string\"},\"credit_card_issuer_and_acquirer_company\":{\"description\":\"Alphanumeric. Acquirer name + \\\";\\\" + card brand (e.g. \\\"VISA\\\").\\n\",\"maxLength\":40,\"type\":\"string\"},\"ecr_data\":{\"description\":\"Alphanumeric. ECR Data field used to transfer user information for private labeled cards like Fleet Card Company (e.g. UTA, outex, etc.). This field is sent from TECS Server to ECR as received.\\n\",\"maxLength\":250,\"type\":\"string\"},\"ex_fee\":{\"description\":\"Numeric. Exchange fee.\\n\",\"maxLength\":100,\"type\":\"string\"},\"exchange_rate\":{\"description\":\"Alphanumeric. Exchange rate at the time of transaction (e.g. 000000000000001,1223).\\n\",\"maxLength\":20,\"type\":\"string\"},\"foreign_tx_amount\":{\"description\":\"Alphanumeric. Transaction amount in desired currency.\\n\",\"maxLength\":20,\"type\":\"string\"},\"merchant_address\":{\"description\":\"Alphanumeric. Merchant address.\\n\",\"maxLength\":50,\"type\":\"string\"},\"merchant_name\":{\"description\":\"Alphanumeric. Merchant name.\\n\",\"maxLength\":25,\"type\":\"string\"},\"message_type\":{\"description\":\"Numeric. Message type:\\n0002 = Transaction response.\\n\",\"maxLength\":4,\"type\":\"string\"},\"operator_id\":{\"description\":\"Alphanumeric. Identification of the operator of the TECS engine installation.\\n\",\"maxLength\":12,\"type\":\"string\"},\"orig_stan\":{\"description\":\"Numeric. STAN of original transaction (for Cancellation).\\n\",\"maxLength\":6,\"type\":\"string\"},\"orig_tx_id\":{\"description\":\"Numeric. Original transaction ID (for Cancellation).\\n\",\"maxLength\":20,\"type\":\"string\"},\"receipt_footer\":{\"description\":\"Alphanumeric. Receipt footer that must be printed on the receipt.\\nContains the authentication method (\\\"PIN VERIFIED\\\" or \\\"SIGNATURE\\\") and tags \\\"AID:\\\" and \\\"AC:\\\".\\n\",\"maxLength\":100,\"type\":\"string\"},\"receipt_header\":{\"description\":\"Alphanumeric. Receipt header.\\n\",\"maxLength\":100,\"type\":\"string\"},\"response_code\":{\"description\":\"Numeric. Response code.\\n\",\"maxLength\":4,\"type\":\"string\"},\"response_text\":{\"description\":\"Alphanumeric. Response text - description of the response code.\\nText is UTF-8 encoded. Binary size of the field is 80 bytes.\\n\",\"maxLength\":80,\"type\":\"string\"},\"serien_nr\":{\"description\":\"Alphanumeric. If present, should be printed on the receipt.\\n\",\"maxLength\":9,\"type\":\"string\"},\"stan\":{\"description\":\"Numeric. TECS Trace Number.\\n\",\"maxLength\":6,\"type\":\"string\"},\"svc\":{\"description\":\"Numeric. Service code (returned by TECS Server). Must be printed on the receipt.\\n\",\"maxLength\":3,\"type\":\"string\"},\"transaction_date_time\":{\"description\":\"Numeric. Transaction date and time (format: yyyymmddhhmmss).\\n\",\"maxLength\":14,\"type\":\"string\"},\"transaction_id\":{\"description\":\"Alphanumeric. Transaction unique identifier (should be the same as sent in the authorization request).\\n\",\"maxLength\":20,\"type\":\"string\"},\"transaction_type\":{\"description\":\"Alphanumeric. Transaction type.\\n\",\"maxLength\":2,\"type\":\"string\"},\"vu_number\":{\"description\":\"Alphanumeric. Merchant Contract number with acquirer.\\n\",\"maxLength\":15,\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Could not communicate with TecsClient\"}},\"security\":[{\"bearerAuth\":[]},{\"basicAuth\":[]}],\"securitySchemes\":{\"basicAuth\":{\"scheme\":\"basic\",\"type\":\"http\"},\"bearerAuth\":{\"bearerFormat\":\"JWT\",\"scheme\":\"bearer\",\"type\":\"http\"}},\"securitySource\":\"operation\"}","source":"openapi3","version":1},"kind":"http","method":"POST","orig":"/makeTransaction","segments":[{"lit":"makeTransaction"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"load":{"input":"data","name":"load","points":[{"active":true,"args":{},"contract":{"id":"GET /version","json":"{\"operationId\":\"getEcrVersion\",\"parameters\":[],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"*/*\":{\"schema\":{\"properties\":{\"appName\":{\"type\":\"string\"},\"buildDate\":{\"type\":\"string\"},\"version\":{\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"OK\"}},\"securitySchemes\":{\"basicAuth\":{\"scheme\":\"basic\",\"type\":\"http\"},\"bearerAuth\":{\"bearerFormat\":\"JWT\",\"scheme\":\"bearer\",\"type\":\"http\"}},\"securitySource\":\"unspecified\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/version","segments":[{"lit":"version"}],"select":{},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"}},"relations":{"ancestors":[]},"key$":"ecr_api","name__orig":"ecr_api","Name":"EcrApi","name_":"ecr_api","name-":"ecr-api","NAME":"ECR_API","index$":0}, {"active":true,"entity":"ecr_api","key$":"BasicEcrApiFlow","kind":"basic","name":"BasicEcrApiFlow","param":{},"step":[{"active":true,"data":{},"input":{"ref":"ecr_api_ref01"},"match":{},"op":"create","spec":[],"valid":[],"index$":0},{"active":true,"data":{},"input":{"ref":"ecr_api_ref01","srcdatavar":"ecr_api_ref01_data","suffix":"_dt0"},"match":{},"op":"load","spec":[],"valid":[{"apply":"TextFieldMark","def":{"mark":"Mark01-ecr_api_ref01"}}],"index$":1}]}, 'EcrApi')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select


    // CREATE
    const ecr_api_ref01_ent = client.EcrApi()
    let ecr_api_ref01_data = setup.data.new.ecr_api['ecr_api_ref01']

    ecr_api_ref01_data = (await ecr_api_ref01_ent.create(ecr_api_ref01_data)).data()
    assert(null != ecr_api_ref01_data)


    // LOAD
    const ecr_api_ref01_match_dt0 = {}
    const ecr_api_ref01_data_dt0 = (await ecr_api_ref01_ent.load(ecr_api_ref01_match_dt0)).data()
    assert(null != ecr_api_ref01_data_dt0)


  })
})



function basicSetup(extra) {
  // TODO: fix test def options
  const options = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname,
      '../../../../.sdk/test/entity/ecr_api/EcrApiTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = BluefinTecsEcrSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['ecr_api01','ecr_api02','ecr_api03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID': idmap,
    'BLUEFIN_TECS_ECR_TEST_LIVE': 'FALSE',
    'BLUEFIN_TECS_ECR_TEST_EXPLAIN': 'FALSE',
    'BLUEFIN_TECS_ECR_APIKEY': '',
  })

  idmap = env['BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID']

  const live = 'TRUE' === env.BLUEFIN_TECS_ECR_TEST_LIVE
  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new BluefinTecsEcrSDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
        apikey: env.BLUEFIN_TECS_ECR_APIKEY,
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when
      // the last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey and
      // server values above and handed the SDK undefined.
      extra || {},
      { system: { fetch: transport.fetch } }
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.BLUEFIN_TECS_ECR_TEST_EXPLAIN,
    live,
    transport,
    now: Date.now(),
  }

  return setup
}
  
