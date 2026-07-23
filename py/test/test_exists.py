# ProjectName SDK exists test

import pytest
from bluefintecsecr_sdk import BluefinTecsEcrSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = BluefinTecsEcrSDK.test(None, None)
        assert testsdk is not None
