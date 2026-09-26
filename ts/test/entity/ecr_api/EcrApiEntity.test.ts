

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { BluefinTecsEcrSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


loadEnvLocal(__dirname + '/../../../.env.local')


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

    const live = 'TRUE' === process.env.BLUEFIN_TECS_ECR_TEST_LIVE
    for (const op of ['create', 'load']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'ecr_api.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"amount":{"a":true,"h":"Amount","n":"amount","r":true,"sh":"Numeric Transaction Amount.","t":"`$STRING`","key$":"amount","index$":0},"authorization_number":{"a":true,"h":"Authorization Number","n":"authorization_number","r":false,"sh":"For Gratuity (msg type 0009): the authorization number of the original transaction.","t":"`$STRING`","key$":"authorization_number","index$":1},"card_number":{"a":true,"h":"Card Number","n":"card_number","r":true,"sh":"Depends on the transaction scenario: - **Standard Pin Pad transaction:** leave empty.","t":"`$STRING`","key$":"card_number","index$":2},"currency":{"a":true,"h":"Currency","n":"currency","r":true,"sh":"ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\").","t":"`$STRING`","key$":"currency","index$":3},"cvc2":{"a":true,"h":"Cvc2","n":"cvc2","r":false,"sh":"Card Verification Code.","t":"`$STRING`","key$":"cvc2","index$":4},"desired_currency":{"a":true,"h":"Desired Currency","n":"desired_currency","r":false,"sh":"ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\").","t":"`$STRING`","key$":"desired_currency","index$":5},"ecr_data":{"a":true,"h":"Ecr Data","n":"ecr_data","r":false,"sh":"ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).","t":"`$STRING`","key$":"ecr_data","index$":6},"language":{"a":true,"h":"Language","n":"language","r":false,"sh":"ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\").","t":"`$STRING`","key$":"language","index$":7},"message_type":{"a":true,"h":"Message Type","n":"message_type","r":false,"sh":"Message type code.","t":"`$STRING`","key$":"message_type","index$":8},"password":{"a":true,"h":"Password","n":"password","r":false,"sh":"Password - currently not used (filled with spaces).","t":"`$STRING`","key$":"password","index$":9},"payment_reason":{"a":true,"h":"Payment Reason","n":"payment_reason","r":false,"sh":"Payment reason (e.g., \"Taxi journey\").","t":"`$STRING`","key$":"payment_reason","index$":10},"payment_reasonAsByte":{"a":true,"h":"Payment Reason As Byte","n":"payment_reasonAsByte","r":false,"sh":"Payment reason represented as a byte array.","t":"`$ARRAY`","key$":"payment_reasonAsByte","index$":11},"personal_id":{"a":true,"h":"Personal Id","n":"personal_id","r":false,"sh":"Identification of the current user of the ECR or Terminal.","t":"`$STRING`","key$":"personal_id","index$":12},"receipt_layout":{"a":true,"h":"Receipt Layout","n":"receipt_layout","r":false,"sh":"Receipt layout identifier.","t":"`$STRING`","key$":"receipt_layout","index$":13},"receipt_number":{"a":true,"h":"Receipt Number","n":"receipt_number","r":false,"sh":"Receipt number.","t":"`$STRING`","key$":"receipt_number","index$":14},"terminal_number":{"a":true,"h":"Terminal Number","n":"terminal_number","r":true,"sh":"Terminal number provided by TECS.","t":"`$STRING`","key$":"terminal_number","index$":15},"transaction_date_time":{"a":true,"h":"Transaction Date Time","n":"transaction_date_time","r":true,"sh":"Transaction date and time (format: yyyymmddhhmmss).","t":"`$STRING`","key$":"transaction_date_time","index$":16},"transaction_id":{"a":true,"h":"Transaction Id","n":"transaction_id","r":true,"sh":"Unique transaction identifier.","t":"`$STRING`","key$":"transaction_id","index$":17},"transaction_origin_identifier":{"a":true,"h":"Transaction Origin Identifier","n":"transaction_origin_identifier","r":false,"sh":"Transaction origin identifier: - 1 = Face to Face (Customer present) - 2 = MOTO (Customer not present) - 4 = Capture/Completion - 5 = Pre Authorization - 7 = Balance","t":"`$STRING`","key$":"transaction_origin_identifier","index$":18},"transaction_origin_indicator":{"a":true,"h":"Transaction Origin Indicator","n":"transaction_origin_indicator","r":false,"sh":"Transaction origin indicator: - 0 = Request for card data on PIN PAD.","t":"`$STRING`","key$":"transaction_origin_indicator","index$":19},"transaction_place":{"a":true,"h":"Transaction Place","n":"transaction_place","r":false,"sh":"The transaction place; the first 5 characters should contain a formatted zip code.","t":"`$STRING`","key$":"transaction_place","index$":20},"transaction_source_id":{"a":true,"h":"Transaction Source Id","n":"transaction_source_id","r":false,"sh":"Identification number of the authorization source.","t":"`$STRING`","key$":"transaction_source_id","index$":21}},"name":"ecr_api","op":{"create":{"input":"data","name":"create","points":[{"a":true,"co":{"id":"POST /makeTransaction","source":"openapi3","version":2},"g":{},"k":"http","m":"POST","o":"/makeTransaction","q":{},"r":{},"s":[{"lit":"makeTransaction"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"create"},"load":{"input":"data","name":"load","points":[{"a":true,"co":{"id":"GET /version","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/version","q":{},"r":{},"s":[{"lit":"version"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"}},"relations":{"ancestors":[]},"key$":"ecr_api","name__orig":"ecr_api","Name":"EcrApi","name_":"ecr_api","name-":"ecr-api","NAME":"ECR_API","index$":0}, {"active":true,"entity":"ecr_api","key$":"BasicEcrApiFlow","kind":"basic","name":"BasicEcrApiFlow","param":{},"step":[{"a":true,"d":{},"i":{"ref":"ecr_api_ref01"},"m":{},"o":"create","s":[],"v":[],"index$":0},{"a":true,"d":{},"i":{"ref":"ecr_api_ref01","srcdatavar":"ecr_api_ref01_data","suffix":"_dt0"},"m":{},"o":"load","s":[],"v":[{"apply":"TextFieldMark","def":{"mark":"Mark01-ecr_api_ref01"}}],"index$":1}]}, 'EcrApi', {"POST /makeTransaction":{"protocol":"http","requestBody":{"content":{"application/json":{"schema":{"type":"object","description":"Request properties for processing a transaction.","properties":{"amount":{"type":"string","description":"Numeric Transaction Amount. According to the ISO 4217 currency exponent, for example:\n- EUR (exponent = 2): 12,55 EUR is represented as \"1255\"\n- BYR (exponent = 0): 15000 BYR is represented as \"15000\"\n","maxLength":11,"example":"1255","key$":"amount"},"authorization_number":{"type":"string","description":"For Gratuity (msg type 0009): the authorization number of the original transaction.\nOtherwise, leave this field empty.\n","maxLength":9,"key$":"authorization_number"},"card_number":{"type":"string","description":"Depends on the transaction scenario:\n- **Standard Pin Pad transaction:** leave empty.\n- **Manual PAN input:** provide card number + \"_\" + expiration date (YYMM).\n- **Swiped card on ECR:** include Track2 data.\n- **Cancellation/Capture (msg type 0013):** \"TXID\" + original transaction number.\n- **Gratuity (msg type 0009) or Credit note (msg type 0011):** \"TXID\" + original transaction number.\n- **Cancellation/Capture from different terminal:** \"TXID\" + \"_\" + \"_\" (e.g., \"TXID00000000001234567890_01_88091234\").\n","maxLength":40,"example":"TXID00000000001234567890","key$":"card_number"},"currency":{"type":"string","description":"ISO 4217 Alpha Currency Code (e.g., \"EUR\", \"USD\").\n","minLength":3,"maxLength":3,"example":"EUR","key$":"currency"},"cvc2":{"type":"string","description":"Card Verification Code.\n","maxLength":4,"example":"123","key$":"cvc2"},"desired_currency":{"type":"string","description":"ISO 4217 Alpha Currency Code in which the transaction will be processed (e.g., \"EUR\", \"USD\").\n","maxLength":3,"example":"USD","key$":"desired_currency"},"ecr_data":{"type":"string","description":"ECR Data field used to transfer user information for private-labeled cards (e.g., Fleet Card Company such as UTA, outex).\nThis field is sent as received.\n","maxLength":250,"example":"ECR123","key$":"ecr_data"},"language":{"type":"string","description":"ISO 639-1 language code used by the Pin Pad user interface during the transaction (e.g., \"en\", \"de\", \"es\").\n","maxLength":2,"example":"en","key$":"language"},"message_type":{"type":"string","description":"Message type code. Allowed values include:\n- 0001 = Purchase, Balance, or Preauthorization\n- 0005 = Purchase with authorization number\n- 0009 = Gratuity\n- 0011 = Credit note\n- 0013 = Cancellation/Capture\n- 0015 = Pre-paid (Mobile Recharge)\n- 0017 = Abort ongoing transaction\n- 0018 = External reader device restart command\n- 0027 = Voucher/Coupon generation\n- 0029 = Card to Card transfer\n- 0034 = End of day (Internal TC only)\n- 2667 = Get connection status (Internal TC only)\n- 2668 = Terminal send diagnostic message (Internal TC only)\n- 4544 = Kill application (Internal TC only)\n- 9043 = Get terminal status\n- 9999 = Initiate CTLS tap event simulator\n- 7976 = Pops-up terminal system menu (Internal TC only)\n","minLength":4,"maxLength":4,"example":"0001","key$":"message_type"},"password":{"type":"string","description":"Password - currently not used (filled with spaces).\n","maxLength":8,"example":"        ","key$":"password"},"payment_reason":{"type":"string","description":"Payment reason (e.g., \"Taxi journey\"). Should be agreed with the acquirer.\nFor Prepaid/Mobile recharge (msg type 0015): \"+\" followed by Operator Code and optional phone number.\n(UTF-8 encoded; maximum binary size is 39 bytes.)\n","maxLength":39,"example":"Taxi journey","key$":"payment_reason"},"payment_reasonAsByte":{"type":"array","description":"Payment reason represented as a byte array.\n","items":{"type":"string","format":"byte"},"example":["0x54","0x61","0x78","0x69"],"key$":"payment_reasonAsByte"},"personal_id":{"type":"string","description":"Identification of the current user of the ECR or Terminal.\n","maxLength":50,"example":"User123","key$":"personal_id"},"receipt_layout":{"type":"string","description":"Receipt layout identifier.\n","maxLength":2,"example":"01","key$":"receipt_layout"},"receipt_number":{"type":"string","description":"Receipt number.\n","maxLength":20,"example":"0123","key$":"receipt_number"},"terminal_number":{"type":"string","description":"Terminal number provided by TECS. For Cancellation/Capture (msg type 0013),\nthis is the terminal number of the original transaction.\n","minLength":8,"maxLength":8,"example":"88091105","key$":"terminal_number"},"transaction_date_time":{"type":"string","description":"Transaction date and time (format: yyyymmddhhmmss).\n","pattern":"^[0-9]{14}$","example":"20240430123045","key$":"transaction_date_time"},"transaction_id":{"type":"string","description":"Unique transaction identifier. Must be unique for every transaction performed on the specified Terminal.\n","maxLength":20,"example":"TX1234567890","key$":"transaction_id"},"transaction_origin_identifier":{"type":"string","description":"Transaction origin identifier:\n- 1 = Face to Face (Customer present)\n- 2 = MOTO (Customer not present)\n- 4 = Capture/Completion\n- 5 = Pre Authorization\n- 7 = Balance\n","minLength":1,"maxLength":1,"example":"1","key$":"transaction_origin_identifier"},"transaction_origin_indicator":{"type":"string","description":"Transaction origin indicator:\n- 0 = Request for card data on PIN PAD.\n- 1 = Face to Face (Magswipe on ECR, no PIN PAD).\n- 2 = Mail order/Telephone order/Manual entry (no PIN PAD).\n","maxLength":1,"example":"0","key$":"transaction_origin_indicator"},"transaction_place":{"type":"string","description":"The transaction place; the first 5 characters should contain a formatted zip code.\n","maxLength":13,"example":"12345","key$":"transaction_place"},"transaction_source_id":{"type":"string","description":"Identification number of the authorization source. In cancellation (msg type 0013),\ngratuity (0009), or credit note (msg type 0011), it should match the original transaction's source ID as provided by TECS.\n","maxLength":2,"example":"01","key$":"transaction_source_id"}},"required":["amount","card_number","currency","terminal_number","transaction_date_time","transaction_id"],"x-ref":"#/components/schemas/TransactionRequest","index$":1}}},"required":true},"parameters":[]},"GET /version":{"protocol":"http","parameters":[]}})
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
    const ecr_api_ref01_match_dt0: any = {}
    const ecr_api_ref01_data_dt0 = (await ecr_api_ref01_ent.load(ecr_api_ref01_match_dt0)).data()
    assert(null != ecr_api_ref01_data_dt0)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

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
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
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
  
