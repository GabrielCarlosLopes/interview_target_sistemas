abstract class HttpClient {
  Future<T> request<T>({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  });
}
