
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'


import { BluefinTecsEcrSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveDelay,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


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
      if (maybeSkipControl(t, 'entityOp', 'ecr_api.' + op, live)) return
    }

    const setup = basicSetup()
    // The basic flow consumes synthetic IDs and field values from the
    // fixture (entity TestData.json). Those don't exist on the live API.
    // Skip live runs unless the user provided a real ENTID env override.
    if (setup.syntheticOnly) {
      t.skip('live entity test uses synthetic IDs from fixture — set BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID JSON to run live')
      return
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

  // Detect whether the user provided a real ENTID JSON via env var. The
  // basic flow consumes synthetic IDs from the fixture file; without an
  // override those synthetic IDs reach the live API and 4xx. Surface this
  // to the test so it can skip rather than fail.
  const idmapEnvVal = process.env['BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID']
  const idmapOverridden = null != idmapEnvVal && idmapEnvVal.trim().startsWith('{')

  const env = envOverride({
    'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID': idmap,
    'BLUEFIN_TECS_ECR_TEST_LIVE': 'FALSE',
    'BLUEFIN_TECS_ECR_TEST_EXPLAIN': 'FALSE',
    'BLUEFIN_TECS_ECR_APIKEY': 'NONE',
  })

  idmap = env['BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID']

  const live = 'TRUE' === env.BLUEFIN_TECS_ECR_TEST_LIVE

  if (live) {
    client = new BluefinTecsEcrSDK(merge([
      {
        apikey: env.BLUEFIN_TECS_ECR_APIKEY,
      },
      extra
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
    syntheticOnly: live && !idmapOverridden,
    now: Date.now(),
  }

  return setup
}
  
