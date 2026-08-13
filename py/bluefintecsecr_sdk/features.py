# BluefinTecsEcr SDK feature factory

from bluefintecsecr_sdk.feature.base_feature import BluefinTecsEcrBaseFeature
from bluefintecsecr_sdk.feature.test_feature import BluefinTecsEcrTestFeature


def _make_feature(name):
    features = {
        "base": lambda: BluefinTecsEcrBaseFeature(),
        "test": lambda: BluefinTecsEcrTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
