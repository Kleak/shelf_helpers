import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_helpers/shelf_helpers.dart';

class TestSerialize {
  final int/*!*/ i;

  TestSerialize(this.i);
}

void main() {
  final pipeline = Pipeline()
      .addMiddleware(cors())
      .addMiddleware(serializeMiddleware((TestSerialize data) => {'i': data.i}))
      .addMiddleware(deserializeMiddleware((data) => TestSerialize(data['i'])));

  final handler = pipeline.addHandler(_echoRequest);
  io.serve(handler, 'localhost', 8080).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });
}

Response _echoRequest(Request request) {
  return serializeResponse(getDeserializedObject(request));
}
