import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_helpers/src/constants.dart';

final deserializeKey = '$shelfHeplersKey/deserialize';

///  allow you to get the deserialized object
T getDeserializedObject<T>(Request request) => request.context[deserializeKey];

/// a middleware to deserialize an object using the [deserializer] function
Middleware deserializeMiddleware<T>(T Function(Map<String, dynamic>) deserializer) {
  return (Handler innerHandler) {
    return (Request request) async {
      final data = await request.readAsString();
      try {
        final object = deserializer(json.decode(data));
        return innerHandler(request.change(
          body: data,
          context: {
            deserializeKey: object,
          },
        ));
      } catch (e) {
        return Response.internalServerError(body: e);
      }
    };
  };
}
