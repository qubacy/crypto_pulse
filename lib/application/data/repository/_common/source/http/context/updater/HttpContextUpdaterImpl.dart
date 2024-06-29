import '../_common/HttpContext.dart';

class HttpContextUpdaterImpl extends HttpContext {
  final String baseUri;

  HttpContextUpdaterImpl({required this.baseUri});
  
  @override
  Future<String> loadUri() async {
    return baseUri;
  }
}