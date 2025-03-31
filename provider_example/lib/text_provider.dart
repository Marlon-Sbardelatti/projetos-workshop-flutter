import 'package:flutter/foundation.dart';

class TextProvider extends ChangeNotifier {
  String _text = 'Escreva algo';
  String get text => _text;

  void updateText(String newText) {
    _text = newText.isEmpty ? 'Escreva algo' : newText;
    notifyListeners();
  }
}
