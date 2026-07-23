package voxgig.bluefintecsecrsdk.utility;

import java.util.LinkedHashMap;
import java.util.Map;

import voxgig.bluefintecsecrsdk.core.Context;
import voxgig.bluefintecsecrsdk.core.Helpers;
import voxgig.bluefintecsecrsdk.core.Response;
import voxgig.bluefintecsecrsdk.core.Result;

final class ResultHeaders {

  private ResultHeaders() {}

  static Result resultHeaders(Context ctx) {
    Response response = ctx.response;
    Result result = ctx.result;

    if (result != null) {
      if (response != null && response.headers != null) {
        Map<String, Object> hm = Helpers.toMapAny(response.headers);
        if (hm != null) {
          result.headers = hm;
        }
        else {
          result.headers = new LinkedHashMap<>();
        }
      }
      else {
        result.headers = new LinkedHashMap<>();
      }
    }

    return result;
  }
}
