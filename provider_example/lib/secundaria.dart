import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/text_provider.dart';

class Secundaria extends StatefulWidget {
  const Secundaria({super.key});

  @override
  State<Secundaria> createState() => _SecundariaState();
}

class _SecundariaState extends State<Secundaria> {
  @override
  Widget build(BuildContext context) {
    final textProvider = Provider.of<TextProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: SizedBox(
            width: 300,
            child: Column(
              children: [
                Consumer<TextProvider>(
                    builder: (context, provider, child) => Text(
                          provider.text,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Digite aqui'),
                  onChanged: (value) {
                    textProvider.updateText(value);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Trocar tela'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
