import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  String _myText = 'Escreva algo';
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    setState(() {
      _textEditingController = TextEditingController();
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  Text(
                    _myText,
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Digite aqui'),
                    onChanged: (value) {
                      setState(() {
                        _myText = value.isEmpty ? 'Escreva algo' : value;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
