import 'package:http/http.dart' as http;
class GoogleClient extends http.BaseClient {
  final Map<String, String> headers;

  final http.Client client;

  GoogleClient(this.headers, this.client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return client.send(request..headers.addAll(headers));
  }
}