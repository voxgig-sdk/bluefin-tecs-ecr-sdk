"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.BluefinTecsEcrError = void 0;
class BluefinTecsEcrError extends Error {
    isBluefinTecsEcrError = true;
    sdk = 'BluefinTecsEcr';
    code;
    ctx;
    status = -1;
    // `err.notFound` rather than a magic number at every call site.
    get notFound() { return 404 === this.status; }
    constructor(code, msg, ctx) {
        super(msg);
        this.code = code;
        this.ctx = ctx;
    }
}
exports.BluefinTecsEcrError = BluefinTecsEcrError;
//# sourceMappingURL=BluefinTecsEcrError.js.map