import { Context } from './Context';
declare class BluefinTecsEcrError extends Error {
    isBluefinTecsEcrError: boolean;
    sdk: string;
    code: string;
    ctx: Context;
    status: number;
    get notFound(): boolean;
    constructor(code: string, msg: string, ctx: Context);
}
export { BluefinTecsEcrError };
