import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecundariaA extends StatelessWidget {
  const SecundariaA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            children: [
              Text(
                'Secundária A',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 220,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/secundaria-b');
                    },
                    child: const Text('Secundária B')),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 220,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: const Text('Voltar para tela principal')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
