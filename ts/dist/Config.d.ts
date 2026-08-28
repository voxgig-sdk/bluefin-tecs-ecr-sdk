import { BaseFeature } from './feature/base/BaseFeature';
declare class Config {
    makeFeature(this: any, fn: string): BaseFeature;
    hasFeature(this: any, fn: string): boolean;
    main: {
        name: string;
        slug: string;
        version: string;
        target: string;
    };
    feature: {
        audit: {
            options: {
                active: boolean;
                actor: string;
                max: number;
            };
            transport: string;
        };
        clienttrack: {
            options: {
                active: boolean;
                clientVersion: string;
            };
            transport: string;
        };
        idempotency: {
            options: {
                active: boolean;
                header: string;
                methods: string[];
                ops: string[];
            };
            transport: string;
        };
        log: {
            options: {
                active: boolean;
            };
            transport: string;
        };
        metrics: {
            options: {
                active: boolean;
            };
            transport: string;
        };
        paging: {
            options: {
                active: boolean;
                afterVar: string;
                cursorParam: string;
                firstVar: string;
                limitParam: string;
                pageParam: string;
                startPage: number;
            };
            transport: string;
        };
        ratelimit: {
            options: {
                active: boolean;
                burst: number;
                rate: number;
            };
            transport: string;
        };
        retry: {
            options: {
                active: boolean;
                factor: number;
                maxDelay: number;
                minDelay: number;
                retries: number;
                statuses: number[];
            };
            transport: string;
        };
        telemetry: {
            options: {
                active: boolean;
            };
            transport: string;
        };
        test: {
            options: {
                active: boolean;
            };
            transport: string;
        };
        timeout: {
            options: {
                active: boolean;
                ms: number;
            };
            transport: string;
        };
    };
    options: {
        base: string;
        auth: {
            prefix: string;
        };
        headers: {
            "content-type": string;
        };
        entity: {
            ecr_api: {};
        };
    };
    entity: {
        ecr_api: {
            fields: ({
                name: string;
                req: boolean;
                short: string;
                type: string;
            } | {
                name: string;
                short: string;
                type: string;
                req?: undefined;
            })[];
            name: string;
            op: {
                create: {
                    input: string;
                    name: string;
                    points: {
                        args: {};
                        kind: string;
                        method: string;
                        orig: string;
                        parts: string[];
                        select: {};
                        transform: {
                            req: string;
                            res: string;
                        };
                    }[];
                };
                load: {
                    input: string;
                    name: string;
                    points: {
                        args: {};
                        kind: string;
                        method: string;
                        orig: string;
                        parts: string[];
                        select: {};
                        transform: {
                            req: string;
                            res: string;
                        };
                    }[];
                };
            };
            relations: {
                ancestors: never[];
            };
        };
    };
}
declare const config: Config;
export { config };
