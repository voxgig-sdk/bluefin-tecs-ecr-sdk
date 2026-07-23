// BluefinTecsEcr SDK public API (generated).

#ifndef BLUEFINTECSECR_API_H
#define BLUEFINTECSECR_API_H

#include "sdk.h"

// EcrApi entity.
Entity* ecr_api_entity_new(BluefinTecsEcrSDK* client, voxgig_value* entopts);
Entity* bluefintecsecr_ecr_api(BluefinTecsEcrSDK* client, voxgig_value* entopts);
voxgig_value* ecr_api_stream(Entity* e, const char* action, voxgig_value* args, voxgig_value* callopts, PNError** err);

#endif // BLUEFINTECSECR_API_H
