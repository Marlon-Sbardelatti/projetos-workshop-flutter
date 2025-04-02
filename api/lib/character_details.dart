import 'package:api/character_model.dart';
import 'package:api/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(38.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Image.network(
                      widget.character.image ?? '',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.character.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'Gender: ',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        widget.character.gender,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'Species: ',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        widget.character.species,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        'Origin planet: ',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        widget.character.originPlanet,
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
