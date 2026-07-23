
const { test, describe } = require('node:test')
const { equal } = require('node:assert')


const { BluefinTecsEcrSDK } = require('..')


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await BluefinTecsEcrSDK.test()
    equal(null !== testsdk, true)
  })

})
