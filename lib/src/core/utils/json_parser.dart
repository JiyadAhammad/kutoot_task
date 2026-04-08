import 'dart:convert';

List<T> parseList<T>(
  String responseBody,
  T Function(Map<String, dynamic>) fromJson,
) {
  final List<dynamic> parsed = jsonDecode(responseBody);

  return parsed
      .map<T>((json) => fromJson(json as Map<String, dynamic>))
      .toList();
}
