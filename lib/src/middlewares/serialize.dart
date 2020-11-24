import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_helpers/src/constants.dart';

final serializeKey = '$shelfHeplersKey/serialize';

/// helper to serialize an [object]
Response serializeResponse<T>(T object) => Response(HttpStatus.ok, context: {
      serializeKey: object,
    });

/// a middleware to serialize an object using the [serializer] function
Middleware serializeMiddleware<T>(Map<String, dynamic> Function(T) serializer) {
  return (Handler innerHandler) {
    return (Request request) async {
      try {
        final response = await innerHandler(request);
        final object = response.context[serializeKey] as T;
        return response.change(
          headers: {
            HttpHeaders.contentTypeHeader: ContentType.json.toString(),
          },
          body: json.encode(serializer(object)),
        );
      } catch (e) {
        return Response.internalServerError(body: e);
      }
    };
  };
}
