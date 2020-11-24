import 'dart:io';

import 'package:shelf/shelf.dart';

/// This [Middleware] will add CORS to you endpoints
Middleware cors(Map<String, String> corsHeaders) {
  return (Handler innerHandler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response(HttpStatus.ok, headers: corsHeaders);
      }
      final response = await innerHandler(request.change(headers: corsHeaders));
      return response.change(headers: corsHeaders);
    };
  };
}
