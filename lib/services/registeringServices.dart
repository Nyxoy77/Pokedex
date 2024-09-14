// import 'dart:ffi';

import 'package:get_it/get_it.dart';
import 'package:pokedex/services/database.dart';
import 'package:pokedex/services/http_service.dart';

Future<void> register() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<HttpService>(HttpService());
  getIt.registerSingleton<Database>(Database());
}
