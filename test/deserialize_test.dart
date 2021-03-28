import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_helpers/shelf_helpers.dart';
import 'package:test/test.dart';

class TestDeserialize {
  final int i;

  TestDeserialize(this.i);
}

void main() {
  group('deserialize', () {
    test('empty body', () async {
      TestDeserialize deserializer(Map<String, dynamic> json) {
        return TestDeserialize(json['i']);
      }

      final response =
          await deserializeMiddleware(deserializer)((_) => Future.value(null))(
              Request('OPTIONS', Uri.parse('http://localhost:8080/')));
      expect(response.statusCode, HttpStatus.internalServerError);
      expect(await response.readAsString(), startsWith('FormatException'));
    });

    test('object', () async {
      TestDeserialize deserializer(Map<String, dynamic> /*!*/ json) {
        return TestDeserialize(json['i']);
      }

      TestDeserialize? receivedValue;

      await deserializeMiddleware(deserializer)((request) {
        receivedValue = getDeserializedObject(request);
        return Future.value(null);
      })(Request('OPTIONS', Uri.parse('http://localhost:8080/'),
          body: json.encode({'i': 42})));
      expect(receivedValue, isNotNull);
      expect(receivedValue!.i, 42);
    });
  });
}
