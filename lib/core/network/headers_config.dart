abstract class HeadersConfig {
  Future<Map<String, String>> headers();
}

class HeadersConfigImpl implements HeadersConfig {
  @override
  Future<Map<String, String>> headers() async {
    var headers = <String, String>{
      'x-access-token': '',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Content-Type': 'application/json'
    };

    return headers;
  }
}
