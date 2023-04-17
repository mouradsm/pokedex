import 'package:flutter/material.dart';
import 'package:pokedex/api/api_service.dart';
import 'package:pokedex/model/pokemon.dart';
import 'package:pokedex/widgets/poke_tile.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _apiService = ApiService();

  final int _numberOfPostsPerRequest = 10;
  late List<Pokemon> _pokemons;

  final _paginController = PagingController<int, Pokemon>(firstPageKey: 1);

  @override
  void initState() {
    _paginController.addPageRequestListener((pageKey) {
      _fetchPokemons(pageKey);
    });

    super.initState();

    _pokemons = [];
  }

  @override
  void dispose() {
    _paginController.dispose();
    super.dispose();
  }

  _fetchPokemons(int pageNumber) async {
    _pokemons = await _apiService.fetchPokemon(page: pageNumber);

    final isLastPage = _pokemons.length < _numberOfPostsPerRequest;

    if (isLastPage) {
      _paginController.appendLastPage(_pokemons);
      return;
    }

    final nextPageKey = pageNumber + 1;

    _paginController.appendPage(_pokemons, nextPageKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: RefreshIndicator(
            onRefresh: () => Future.sync(() => _paginController.refresh()),
            child: Column(children: [
              Row(children: <Widget>[
                Expanded(
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.widgets),
                      SizedBox(
                        width: 5,
                      ),
                      Text('App',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24))
                    ],
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.search),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.favorite)
                  ],
                )),
              ]),
              Expanded(
                  child: PagedListView<int, Pokemon>(
                padding: const EdgeInsets.all(8),
                pagingController: _paginController,
                //itemCount: (_pokemons.length),
                builderDelegate: PagedChildBuilderDelegate<Pokemon>(
                    itemBuilder: (context, item, index) {
                  return PokeTile(
                      name: item.name,
                      id: item.id,
                      image: item.image,
                      type_1: item.type_1,
                      type_2: item.type_2);
                }),
              ))
            ]),
          ),
        ),
      ),
    );
  }
}
