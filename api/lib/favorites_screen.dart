import 'dart:convert';
import 'package:api/character_details.dart';
import 'package:api/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:api/character_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  final List<int> ids;

  const FavoritesScreen({super.key, required this.ids});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Character> _characters = [];
  bool _isLoading = true;

  Future<void> fetchCharacters() async {
    final res = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character/${widget.ids}'));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      List<Character> characters = [];
      List<dynamic> charactersJson = data;
      characters.addAll(
          charactersJson.map((json) => Character.fromJson(json)).toList());

      setState(() {
        _characters = characters;
        _isLoading = false;
      });
    } else {
      throw Exception('Erro ao carregar imagem');
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.ids.isNotEmpty) {
      fetchCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: widget.ids.isEmpty
          ? Center(
              child: const Text('Você não favoritou nenhum personagem'),
            )
          : _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text(
                        'Favoritos',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: _characters.length,
                          itemBuilder: (context, index) {
                            final character = _characters[index];

                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CharacterDetailsScreen(
                                                  character: character)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    elevation: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                            child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(15)),
                                          child: Image.network(
                                            character.image ?? '',
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            character.name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await SharedPreferencesHelper.removeIdList(),
        child: Icon(Icons.delete),
      ),
    );
  }
}
