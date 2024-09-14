import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pokedex/models_req/models.dart';
import 'package:pokedex/providers/pokemon_data_providers.dart';

class InfoCard extends ConsumerWidget {
  final String pokemonURL;

  const InfoCard({super.key, required this.pokemonURL});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(dataProvider(pokemonURL));

    return AlertDialog(
      title: const Text("Statistics"),
      content: pokemon.when(data: (data) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: data?.stats?.map(
                (s) {
                  return Text("${s.stat?.name?.toUpperCase()} : ${s.baseStat}");
                },
              ).toList() ??
              [],
        );
      }, error: (error, stacktrace) {
        return Text('ERROR $error');
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
