import 'dart:convert';
import 'dart:async';
import 'package:api/character_details.dart';
import 'package:api/character_model.dart';
import 'package:api/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Character> _characters = [];
  bool _isLoading = true;
  bool _isFetchingMore = false;
  String nextPageUrl = '';
  Timer? _debounce;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchCharacters();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _getCharacterByParam(String param) async {
    if (param == '') {
      setState(() {
        _isLoading = true;
      });

      await fetchCharacters();
      return;
    }

    final res = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character/?name=$param'));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      List<Character> characters = [];
      List<dynamic> charactersJson = data['results'];
      characters.addAll(
          charactersJson.map((json) => Character.fromJson(json)).toList());

      setState(() {
        if (data['info']['next'] != null) {
          nextPageUrl = data['info']['next'];
        } else {
          nextPageUrl = '';
        }
        _characters = characters;
      });
    } else {
      throw Exception('Erro ao carregar imagem');
    }
  }

  void _onScroll() async {
    if (_isFetchingMore || nextPageUrl == '') return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      await _loadMoreCharacters();
    }
  }

  Future<void> _loadMoreCharacters() async {
    if (_isFetchingMore) {
      return;
    }

    setState(() {
      _isFetchingMore = true;
    });

    final res = await http.get(Uri.parse(nextPageUrl));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      List<Character> characters = [];
      List<dynamic> charactersJson = data['results'];
      characters.addAll(
          charactersJson.map((json) => Character.fromJson(json)).toList());

      setState(() {
        if (data['info']['next'] != null) {
          nextPageUrl = data['info']['next'];
        } else {
          nextPageUrl = '';
        }
        _characters += characters;
        _isLoading = false;
      });
    } else {
      throw Exception('Erro ao carregar imagem');
    }

    setState(() {
      _isFetchingMore = false;
    });
  }

  Future<void> fetchCharacters() async {
    final res =
        await http.get(Uri.parse('https://rickandmortyapi.com/api/character/'));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      List<Character> characters = [];
      List<dynamic> charactersJson = data['results'];
      characters.addAll(
          charactersJson.map((json) => Character.fromJson(json)).toList());

      setState(() {
        if (data['info']['next'] != null) {
          nextPageUrl = data['info']['next'];
        } else {
          nextPageUrl = '';
        }
        _characters = characters;
        _isLoading = false;
      });
    } else {
      throw Exception('Erro ao carregar imagem');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(
            'Rick and Morty',
          ),
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();

                          _debounce = Timer(const Duration(milliseconds: 100),
                              () async {
                            await _getCharacterByParam(value);
                          });
                        }),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        controller: _scrollController,
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
                                      borderRadius: BorderRadius.circular(15)),
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
              ));
  }
}
