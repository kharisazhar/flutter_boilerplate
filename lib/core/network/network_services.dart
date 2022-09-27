import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'base_url.dart';
import 'headers_config.dart';

class NetworkServices {
  final HeadersConfig headersConfig;
  final HttpClient httpClient;

  NetworkServices({required this.headersConfig, required this.httpClient});

  Future<http.Response> clientGet(
      {required String endpoint,
      required http.Client client,
      String? params}) async {
    final String url = '${BaseUrl.baseUrl}$endpoint${params ?? ''}';

    final response = await client.get(Uri.parse(url),
        headers: await headersConfig.headers());

    return response;
  }

  Future<http.Response> clientPost({
    required String endpoint,
    required http.Client client,
    String params = '',
    dynamic body = const {},
  }) async {
    final String url = '${BaseUrl.baseUrl}$endpoint$params';

    final response = await client.post(
      Uri.parse(url),
      headers: await headersConfig.headers(),
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> clientPut(
      {required String endpoint,
      required http.Client client,
      required dynamic body}) async {
    final String url = '${BaseUrl.baseUrl}$endpoint';

    final response = await client.put(Uri.parse(url),
        headers: await headersConfig.headers(), body: jsonEncode(body));

    return response;
  }

  Future<http.Response> clientDelete(
      {required String endpoint,
      required http.Client client,
      required dynamic body}) async {
    final String url = '${BaseUrl.baseUrl}$endpoint';

    final response = await client.delete(Uri.parse(url),
        headers: await headersConfig.headers(), body: jsonEncode(body));

    return response;
  }
}
