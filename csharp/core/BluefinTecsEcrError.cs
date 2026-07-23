// BluefinTecsEcrError - the SDK error type. Carries the pipeline error code,
// the originating context and cleaned result/spec snapshots.

namespace BluefinTecsEcrSdk;

public class BluefinTecsEcrError : Exception
{
    public bool IsBluefinTecsEcrError = true;
    public string Sdk = "BluefinTecsEcr";
    public string Code;
    public Context? Ctx;
    public object? ResultVal;
    public object? SpecVal;

    public BluefinTecsEcrError(string code, string msg, Context? ctx)
        : base(msg)
    {
        Code = code;
        Ctx = ctx;
    }
}
