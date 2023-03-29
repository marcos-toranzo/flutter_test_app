enum StatusCode {
  ok(200),
  timeout(408);

  final int code;
  const StatusCode(this.code);
}
