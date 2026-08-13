
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

const Path = require('node:path')
const Fs = require('node:fs')

const { test, describe } = require('node:test')
const assert = require('node:assert')


const { BluefinTecsEcrSDK, BaseFeature, stdutil, config } = require('../../..')

const {
  envOverride,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
} = require('../../utility')


describe('EcrApiEntity', async () => {

  test('instance', async () => {
    const testsdk = BluefinTecsEcrSDK.test()
    const ent = testsdk.EcrApi()
    assert(null != ent)
  })


  test('basic', async () => {

    const setup = basicSetup()
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
    'BLUEFIN_TECS_ECR_APIKEY': 'NONE',
  })

  idmap = env['BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID']

  if ('TRUE' === env.BLUEFIN_TECS_ECR_TEST_LIVE) {
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
    now: Date.now(),
  }

  return setup
}
  
