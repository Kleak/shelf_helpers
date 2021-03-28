import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_helpers/shelf_helpers.dart';
import 'package:test/test.dart';

void main() {
  group('cors', () {
    test('default', () async {
      final response = await cors()((_) => Future.value(null))(
          Request('OPTIONS', Uri.parse('http://localhost:8080/')));
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.headers.containsKey('Access-Control-Allow-Origin'),
          equals(true));
      expect(response.headers.containsKey('Access-Control-Allow-Methods'),
          equals(true));
      expect(response.headers.containsKey('Access-Control-Allow-Headers'),
          equals(true));
    });

    test('custom', () async {
      final response = await cors(headers: {'greetings': 'Hello shelf'})(
              (_) => Future.value(null))(
          Request('OPTIONS', Uri.parse('http://localhost:8080/')));
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.headers.containsKey('greetings'), equals(true));
      expect(response.headers.containsKey('Access-Control-Allow-Methods'),
          equals(false));
      expect(response.headers.containsKey('Access-Control-Allow-Headers'),
          equals(false));
    });
  });
}
