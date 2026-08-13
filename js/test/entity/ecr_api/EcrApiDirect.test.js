
const envlocal = __dirname + '/../../../.env.local'
require('dotenv').config({ quiet: true, path: [envlocal] })

const { test, describe } = require('node:test')
const assert = require('node:assert')


const { BluefinTecsEcrSDK } = require('../../..')

const {
  envOverride,
} = require('../../utility')


describe('EcrApiDirect', async () => {

  test('direct-exists', async () => {
    const sdk = new BluefinTecsEcrSDK({
      // Concrete base: a live construction must satisfy any server
      // variables a templated base URL declares; overriding base with a
      // literal (as the direct flow tests do) sidesteps the requirement.
      base: 'http://localhost:8080',
      system: { fetch: async () => ({}) }
    })
    assert('function' === typeof sdk.direct)
    assert('function' === typeof sdk.prepare)
  })


  test('direct-load-ecr_api', async () => {
    const setup = directSetup({ id: 'direct01' })
    const { client, calls } = setup

    const params = {}
    if (!setup.live) {

    }

    const result = await client.direct({
      path: 'version',
      method: 'GET',
      params,
    })

    assert(result.ok === true)
    assert(result.status === 200)
    assert(null != result.data)

    if (!setup.live) {
      assert(result.data.id === 'direct01')
      assert(calls.length === 1)
      assert(calls[0].init.method === 'GET')
    }
  })

})



function directSetup(mockres) {
  const calls = []

  const env = envOverride({
    'BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID': {},
    'BLUEFIN_TECS_ECR_TEST_LIVE': 'FALSE',
    'BLUEFIN_TECS_ECR_APIKEY': 'NONE',
  })

  const live = 'TRUE' === env.BLUEFIN_TECS_ECR_TEST_LIVE

  if (live) {
    const client = new BluefinTecsEcrSDK({
      apikey: env.BLUEFIN_TECS_ECR_APIKEY,
    })

    let idmap = env['BLUEFIN_TECS_ECR_TEST_ECR_API_ENTID']
    if ('string' === typeof idmap && idmap.startsWith('{')) {
      idmap = JSON.parse(idmap)
    }

    return { client, calls, live, idmap }
  }

  const mockFetch = async (url, init) => {
    calls.push({ url, init })
    return {
      status: 200,
      statusText: 'OK',
      headers: {},
      json: async () => (null != mockres ? mockres : { id: 'direct01' }),
    }
  }

  const client = new BluefinTecsEcrSDK({
    base: 'http://localhost:8080',
    system: { fetch: mockFetch },
  })

  return { client, calls, live, idmap: {} }
}
  
