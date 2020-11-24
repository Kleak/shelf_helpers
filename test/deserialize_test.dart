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
    test('object', () async {
      TestDeserialize deserializer(Map<String, dynamic> json) {
        return TestDeserialize(json['i']);
      }

      TestDeserialize receivedValue;

      await deserializeMiddleware(deserializer)((request) {
        receivedValue = getDeserializedObject(request);
        return null;
      })(Request(
        'OPTIONS',
        Uri.parse('http://localhost:8080/'),
        body: json.encode({'i': 42}),
      ));
      expect(receivedValue, isNotNull);
      expect(receivedValue.i, 42);
    });
  });
}
