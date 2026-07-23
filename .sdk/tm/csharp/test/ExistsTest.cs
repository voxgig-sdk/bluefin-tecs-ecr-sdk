// BluefinTecsEcr SDK exists test.

using Xunit;

using BluefinTecsEcrSdk;

namespace BluefinTecsEcrSdk.Test;

public class ExistsTest
{
    [Fact]
    public void TestMode()
    {
        var testsdk = BluefinTecsEcrSDK.TestSDK(null, null);
        Assert.NotNull(testsdk);
    }
}
