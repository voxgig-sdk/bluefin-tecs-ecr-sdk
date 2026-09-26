
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { BluefinTecsEcrSDK } from '..'


describe('exists', async () => {

  test('test-mode', () => {
    const testsdk = BluefinTecsEcrSDK.test()
    equal(testsdk instanceof BluefinTecsEcrSDK, true,
      'BluefinTecsEcrSDK.test() must return a client synchronously')
  })

})
