
import { Context } from './Context'


class BluefinTecsEcrError extends Error {

  isBluefinTecsEcrError = true

  sdk = 'BluefinTecsEcr'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  BluefinTecsEcrError
}

