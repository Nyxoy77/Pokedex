import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/models_req/models.dart';
import 'package:pokedex/providers/pokemon_data_providers.dart';
import 'package:pokedex/widgets/info_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ignore: must_be_immutable
class PokemonCard extends ConsumerWidget {
  final String pokemonURL;
  late FavoritePokemonNotifier _favoritePokemonNotifier;

  PokemonCard(this.pokemonURL, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _favoritePokemonNotifier = ref.watch(favoritePokemonProvider.notifier);

    final pokemon = ref.watch(dataProvider(pokemonURL));
    return pokemon.when(data: (data) {
      return _card(context, false, data);
    }, error: (error, stacktrace) {
      return Text("Error $error");
    }, loading: () {
      return _card(context, true, null);
    });
  }

  Widget _card(BuildContext context, bool isloading, Pokemon? pokemon) {
    return Skeletonizer(
      enabled: isloading,
      ignoreContainers: true,
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) {
                return InfoCard(pokemonURL: pokemonURL);
              });
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.03,
            vertical: MediaQuery.sizeOf(context).height * 0.01,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.03,
            vertical: MediaQuery.sizeOf(context).height * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).primaryColor,
            boxShadow: const [
              BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 10)
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon?.name?.toUpperCase() ?? "pokemon",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "# ${pokemon?.id}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Expanded(
                child: CircleAvatar(
                  backgroundImage: pokemon != null
                      ? NetworkImage(pokemon.sprites!.frontDefault!)
                      : null,
                  radius: MediaQuery.sizeOf(context).height * 0.05,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${pokemon?.moves?.length} Moves",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        _favoritePokemonNotifier.removeFavPokemon(pokemonURL);
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
