import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/models_req/models.dart';
import 'package:pokedex/providers/pokemon_data_providers.dart';
import 'package:pokedex/widgets/info_card.dart';
import 'package:skeletonizer/skeletonizer.dart';
// import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class PokemonListTile extends ConsumerWidget {
  final String pokemonURL;
  late FavoritePokemonNotifier _favoritePokemonNotifier;
  late List<String> _listFavPokemons;

  PokemonListTile({
    super.key,
    required this.pokemonURL,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _favoritePokemonNotifier = ref.watch(favoritePokemonProvider.notifier);
    _listFavPokemons = ref.watch(favoritePokemonProvider);
    final pokemninfo = ref.watch(
      dataProvider(pokemonURL),
    );
    return pokemninfo.when(
      data: (data) => _setUp(context, false, data),
      error: (error, stackTrace) => Text("Error $error"),
      loading: () => _setUp(context, true, null),
    ); // so nice we can return a widget once we get the data and handle loading and error states
  }

  Widget _setUp(BuildContext context, bool isloading, Pokemon? pokemon) {
    return Skeletonizer(
      enabled: isloading,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return InfoCard(pokemonURL: pokemonURL);
              });
        },
        child: ListTile(
          leading: pokemon != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(
                    pokemon.sprites!.frontDefault!,
                  ),
                )
              : const CircleAvatar(),
          title: Text(
            pokemon != null
                ? pokemon.name!.toUpperCase()
                : "Currently loading names of pokemon",
          ),
          subtitle: Text("Has ${pokemon?.moves?.length.toString() ?? 0} moves"),
          trailing: IconButton(
            onPressed: () {
              if (_listFavPokemons.contains(pokemonURL)) {
                _favoritePokemonNotifier.removeFavPokemon(pokemonURL);
              } else {
                _favoritePokemonNotifier.addFavPokemon(pokemonURL);
              }
            },
            icon: Icon(
              _listFavPokemons.contains(pokemonURL)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
