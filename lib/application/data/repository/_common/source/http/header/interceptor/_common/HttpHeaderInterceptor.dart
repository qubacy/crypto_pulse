abstract class HttpHeaderInterceptor {
  Future<void> intercept(Map<String, String> headers);
}