import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pokedex/model/pokemon.dart';

class ApiService {
  Future<List<Pokemon>> fetchPokemon({int page = 1}) async {
    List<Pokemon> pokemons = [];

    int pageSize = 10;
    int offset = (page * 10) - pageSize;

    try {
      for (int i = 1; i <= pageSize; i++) {
        var id = i + offset;

        if (id > 152) break;

        var url = Uri.parse('https://pokeapi.co/api/v2/pokemon/${id}');

        final response = await http.get(url);

        var pokeInfo = jsonDecode(response.body);

        pokemons.add(Pokemon(
            name: pokeInfo['name'],
            id: pokeInfo['id'],
            url: url.toString(),
            type_1: pokeInfo['types'][0]['type']['name'],
            type_2: pokeInfo['types'].length > 1
                ? pokeInfo['types'][1]['type']['name']
                : null,
            image: pokeInfo['sprites']['other']['official-artwork']
                ['front_default']));
      }

      return pokemons;
    } catch (e) {
      log(e.toString());
    }

    return pokemons;
  }
}
