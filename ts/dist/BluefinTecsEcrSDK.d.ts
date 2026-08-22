import { EcrApiEntity } from './entity/EcrApiEntity';
export type * from './BluefinTecsEcrTypes';
import { inspect } from 'node:util';
import type { Context, Feature } from './types';
import { config } from './Config';
import { BluefinTecsEcrEntityBase } from './BluefinTecsEcrEntityBase';
import { Utility } from './utility/Utility';
import { BaseFeature } from './feature/base/BaseFeature';
declare const stdutil: Utility;
declare class BluefinTecsEcrSDK {
    _mode: string;
    _options: any;
    _utility: Utility;
    _features: Feature[];
    _rootctx: Context;
    constructor(options?: any);
    options(): any;
    utility(): any;
    prepare(fetchargs?: any): Promise<any>;
    direct(fetchargs?: any): Promise<Error | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    } | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    }>;
    _rawRequest(fetchargs?: any): Promise<Error | {
        ok: boolean;
        status: number;
        headers: any;
        data: any;
        err?: undefined;
    } | {
        ok: boolean;
        err: any;
        status?: undefined;
        headers?: undefined;
        data?: undefined;
    }>;
    graphql(query: string, variables?: any, ctrl?: any): Promise<any>;
    EcrApi(entopts?: Record<string, any>): EcrApiEntity;
    static test(testoptsarg?: any, sdkoptsarg?: any): BluefinTecsEcrSDK;
    tester(testopts?: any, sdkopts?: any): BluefinTecsEcrSDK;
    toJSON(): {
        name: string;
    };
    toString(): string;
    [inspect.custom](): string;
}
declare const SDK: typeof BluefinTecsEcrSDK;
export { stdutil, config, BaseFeature, BluefinTecsEcrEntityBase, BluefinTecsEcrSDK, SDK, };
