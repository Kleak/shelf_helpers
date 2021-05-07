import 'dart:io' show HttpHeaders;

extension CORSHeadersExt on HttpHeaders {
  static const corsAllowedOriginsHeader = CORSHeaders;
}

//This could be generated with a code builder from https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers#cors
class CORSHeaders {
  static const String accessControlAllowOriginHeader = 'Access-Control-Allow-Origin';
  static const String accessControlAllowHeadersHeader = 'Access-Control-Allow-Headers';
  static const String accessControlAllowMethodsHeader = 'Access-Control-Allow-Methods';
  static const String accessControlAllowCredentialsHeader =
      'Access-Control-Allow-Credentials';
  static const String accessControlExposeHeadersHeader = 'Access-Control-Expose-Headers';
  static const String accessControlMaxAgeHeader = 'Access-Control-Max-Age';
  static const String accessControlRequestHeadersHeader = 'Access-Control-Request-Headers';
  static const String accessControlRequestMethodHeader = 'Access-Control-Request-Method';
}
