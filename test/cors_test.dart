import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_helpers/shelf_helpers.dart';
import 'package:test/test.dart';

void main() {
  group('cors', () {
    test('default', () async {
      final response = await cors()((_) => null)(
          Request('OPTIONS', Uri.parse('http://localhost:8080/')));
      expect(response.statusCode, HttpStatus.ok);
      expect(
          response.headers.containsKey('Access-Control-Allow-Origin'), isTrue);
      expect(
          response.headers.containsKey('Access-Control-Allow-Methods'), isTrue);
      expect(
          response.headers.containsKey('Access-Control-Allow-Headers'), isTrue);
    });

    test('custom', () async {
      final response = await cors(headers: {'greetings': 'Hello shelf'})(
          (_) => null)(Request('OPTIONS', Uri.parse('http://localhost:8080/')));
      expect(response.statusCode, HttpStatus.ok);
      expect(response.headers.containsKey('greetings'), isTrue);
      expect(response.headers.containsKey('Access-Control-Allow-Methods'),
          isFalse);
      expect(response.headers.containsKey('Access-Control-Allow-Headers'),
          isFalse);
    });
  });
}
