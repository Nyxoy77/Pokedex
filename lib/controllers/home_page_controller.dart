// import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/models_req/models.dart';
import 'package:pokedex/models_req/page_data.dart';
import 'package:pokedex/services/http_service.dart';

class HomePageController extends StateNotifier<HomePageData> {
  final GetIt _getIt = GetIt.instance;
  late HttpService _httpService;

  HomePageController(super._state) {
    _httpService = _getIt.get<HttpService>();
    _setUp();
  }

  Future<void> _setUp() async {
    loadData();
  }

  Future<void> loadData() async {
    if (state.data == null) {
      Response? res = await _httpService
          .getData("https://pokeapi.co/api/v2/pokemon?limit=20&offset=0");
      // print(res);
      if (res != null && res.data != null) {
        PokemonListData pokemonListData = PokemonListData.fromJson(res.data);
        state = state.copyWith(data: pokemonListData);
      }
    } else {
      if (state.data?.next != null) {
        Response? res = await _httpService.getData(state.data!.next!);
        if (res != null && res.data != null) {
          PokemonListData data = PokemonListData.fromJson(res.data);
          state = state.copyWith(
            data: data.copyWith(
              results: [
                ...?state.data!.results,
                ...?data.results,
              ],
            ),
          );
        }
      }
    }
  }
}
