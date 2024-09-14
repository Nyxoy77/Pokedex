import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/controllers/home_page_controller.dart';
import 'package:pokedex/models_req/models.dart';
import 'package:pokedex/models_req/page_data.dart';
import 'package:pokedex/providers/pokemon_data_providers.dart';
import 'package:pokedex/services/http_service.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:pokedex/widgets/pokemon_list.dart';

final homePageControllerProvider =
    StateNotifierProvider<HomePageController, HomePageData>(
  (ref) {
    return HomePageController(
      HomePageData.initial(),
    );
  },
);

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final GetIt getIt = GetIt.instance;
  late final HttpService httpService;

  late HomePageController _homePageController;
  final ScrollController allPokemonListController = ScrollController();
  late HomePageData _homePageData;
  late List<String> listPokemon;

  @override
  void initState() {
    httpService = getIt.get<HttpService>();
    allPokemonListController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    allPokemonListController.removeListener(_scrollListener);
    allPokemonListController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (allPokemonListController.offset >=
            allPokemonListController.position.maxScrollExtent * 1 &&
        !allPokemonListController.position.outOfRange) {
      _homePageController.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    _homePageController = ref.watch(
      homePageControllerProvider.notifier,
    );

    _homePageData = ref.watch(homePageControllerProvider);

    listPokemon = ref.watch(favoritePokemonProvider);
    listPokemon = listPokemon.where((url) => url.isNotEmpty).toList();

    return Scaffold(
      body: _buildUi(context, mq),
    );
  }

  Widget _buildUi(BuildContext context, MediaQueryData mq) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.size.width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _favoritePokemonList(context),
            _allPokemonList(context),
          ],
        ),
      ),
    );
  }

  Widget _favoritePokemonList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "FAVORITES",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.5,
          child: listPokemon.isNotEmpty
              ? GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    String url = listPokemon[index];
                    print(url);
                    return PokemonCard(url);
                  },
                  itemCount: listPokemon.length,
                )
              : const Center(
                  child: Text("No favorite Pokémon yet"),
                ),
        ),
      ],
    );
  }

  Widget _allPokemonList(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Pokemon',
            style: TextStyle(fontSize: 25),
          ),
          Expanded(
            child: ListView.builder(
              controller: allPokemonListController,
              itemCount: _homePageData.data?.results?.length ?? 0,
              itemBuilder: (context, index) {
                PokemonListResult instance =
                    _homePageData.data!.results![index];
                return PokemonListTile(
                  pokemonURL: instance.url!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
