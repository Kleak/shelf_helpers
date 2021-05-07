import 'dart:io' show HttpHeaders;

extension CORSHeadersExt on HttpHeaders {
  static const corsAllowedOriginsHeader = CORSHeaders;
}

//This could be generated with a code builder from https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers#cors
class CORSHeaders {
  static const String allowedOriginsHeader = 'Access-Control-Allow-Origin';
  static const String allowedHeadersHeader = 'Access-Control-Allow-Headers';
  static const String allowedMethodsHeader = 'Access-Control-Allow-Methods';
  static const String allowedCredentialsHeader =
      'Access-Control-Allow-Credentials';
  static const String exposableHeadersHeader = 'Access-Control-Expose-Headers';
  static const String maxAgeHeader = 'Access-Control-Max-Age';
  static const String requestHeadersHeader = 'Access-Control-Request-Headers';
  static const String requestMethodHeader = 'Access-Control-Request-Method';
}
