// Generated instance test for the ecr_api entity.

#include "ctest.h"

int main(void) {
  BluefinTecsEcrSDK* sdk = test_sdk(NULL, NULL);
  CHECK(sdk != NULL, "sdk constructed");

  Entity* e = bluefintecsecr_ecr_api(sdk, NULL);
  CHECK(e != NULL, "entity instance");
  CHECK_STR_EQ(e->vt->get_name(e), "ecr_api", "entity get_name");

  TEST_SUMMARY("ecr_api_entity");
}
