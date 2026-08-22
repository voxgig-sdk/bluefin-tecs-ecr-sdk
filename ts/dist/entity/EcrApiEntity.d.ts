import { BluefinTecsEcrEntityBase } from '../BluefinTecsEcrEntityBase';
import type { BluefinTecsEcrSDK } from '../BluefinTecsEcrSDK';
import type { Control } from '../types';
import type { EcrApi, EcrApiLoadMatch, EcrApiCreateData } from '../BluefinTecsEcrTypes';
declare class EcrApiEntity extends BluefinTecsEcrEntityBase<EcrApi> {
    constructor(client: BluefinTecsEcrSDK, entopts: any);
    make(this: EcrApiEntity): EcrApiEntity;
    load(this: any, reqmatch?: EcrApiLoadMatch, ctrl?: Control): Promise<EcrApiEntity>;
    create(this: any, reqdata?: EcrApiCreateData, ctrl?: Control): Promise<EcrApiEntity>;
}
export { EcrApiEntity };
