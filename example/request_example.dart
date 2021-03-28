import 'dart:convert';

import 'package:http/http.dart';

void main() async {
  final response = await post(
    Uri.parse('http://localhost:8080'),
    encoding: utf8,
    body: json.encode({'i': 42}),
  );

  print(response.statusCode);
  print(response.headers);
  print(response.body);
}
