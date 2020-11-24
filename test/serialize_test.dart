import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_helpers/shelf_helpers.dart';
import 'package:test/test.dart';

class TestSerialize {
  final int i;

  TestSerialize(this.i);
}

void main() {
  group('serialize', () {
    test('fail to serialize', () async {
      Map<String, dynamic> serializer(TestSerialize object) {
        throw ArgumentError();
      }

      final response = await serializeMiddleware(serializer)(
              (request) => serializeResponse(TestSerialize(12)))(
          Request('OPTIONS', Uri.parse('http://localhost:8080/')));
      expect(response.statusCode, equals(HttpStatus.internalServerError));
    });

    test('object', () async {
      Map<String, dynamic> serializer(TestSerialize object) {
        return {
          'i': object.i,
        };
      }

      final response = await serializeMiddleware(serializer)(
              (request) => serializeResponse(TestSerialize(12)))(
          Request('OPTIONS', Uri.parse('http://localhost:8080/')));
      expect(
          response.headers.containsKey(HttpHeaders.contentTypeHeader), isTrue);
    });
  });
}
