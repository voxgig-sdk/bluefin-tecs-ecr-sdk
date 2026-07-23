// BluefinTecsEcr SDK public API (generated).

#ifndef BLUEFIN_TECS_ECR_API_H
#define BLUEFIN_TECS_ECR_API_H

#include "sdk.h"

// EcrApi entity.
Entity* ecr_api_entity_new(BluefinTecsEcrSDK* client, voxgig_value* entopts);
Entity* bluefin_tecs_ecr_ecr_api(BluefinTecsEcrSDK* client, voxgig_value* entopts);
voxgig_value* ecr_api_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);

#endif // BLUEFIN_TECS_ECR_API_H
