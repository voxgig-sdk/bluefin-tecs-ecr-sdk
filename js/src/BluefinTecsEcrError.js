

class BluefinTecsEcrError extends Error {

  isBluefinTecsEcrError = true

  sdk = 'BluefinTecsEcr'

  constructor(code, msg, ctx) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

module.exports = {
  BluefinTecsEcrError
}

