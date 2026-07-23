class BluefinTecsEcrError extends Error {
  final bool isBluefinTecsEcrError = true;

  final String sdk = 'BluefinTecsEcr';

  String code;
  String message;
  dynamic ctx;

  // Populated by makeError with the (cleaned) result and spec.
  dynamic result;
  dynamic spec;

  BluefinTecsEcrError(this.code, this.message, [this.ctx]);

  @override
  String toString() => 'BluefinTecsEcrError: ' + code + ': ' + message;
}
