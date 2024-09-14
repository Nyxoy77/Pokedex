import 'package:dio/dio.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/models_req/models.dart';
import 'package:pokedex/services/database.dart';
import 'package:pokedex/services/http_service.dart';

// This means that Pokemon object would be returned to us and String along with ref will be passed
//as an arguement
final dataProvider = FutureProvider.family<Pokemon?, String>((ref, url) async {
  HttpService httpService = GetIt.instance.get<HttpService>();
  Response? res = await httpService.getData(url);

  if (res != null && res.data != null) {
    return Pokemon.fromJson(res.data);
  }
  return null;
});

final favoritePokemonProvider =
    StateNotifierProvider<FavoritePokemonNotifier, List<String>>(
  (ref) {
    return FavoritePokemonNotifier([]); // initial state no pokemons url
  },
);

class FavoritePokemonNotifier extends StateNotifier<List<String>> {
  final Database _database = GetIt.instance.get<Database>();
  String databaseKey = "databaseKey";
  // For making pokemons favorite and using them to show in grid
  // at the top
  FavoritePokemonNotifier(super.state) {
    _setUp();
  }

  Future<void> _setUp() async {
    List<String>? data = await _database.loadList(databaseKey);

    state = data ?? [];
  }

  void addFavPokemon(String url) {
    state = [...state, url];
    _database.saveList(databaseKey, state);
  }

  void removeFavPokemon(String url) {
    state = state.where((e) => e != url).toList();
    _database.saveList(databaseKey, state);
  }
}
