import 'package:dio/dio.dart';

class HttpService {
  HttpService();
  // _configureDio();

  final dio = Dio();

  // void _configureDio() {
  //   dio.options = BaseOptions(
  //     baseUrl: 'https://pokeapi.co/api/v2/pokemon?',
  //     connectTimeout: const Duration(minutes: 1),
  //   );
  // }

  Future<Response?> getData(String? path) async {
    if (path != null) {
      Response response = await dio.get(path);
      return response;
    }
    return null;
  }
}
