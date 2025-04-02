import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveToFavorites(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String idString = id.toString();
    List<String>? listIds = prefs.getStringList('id_list');

    // já existe pelo menos um id
    if (listIds != null) {
      listIds.add(idString);
      await prefs.setStringList('id_list', listIds);
      return;
    } else {
      List<String> newListIds = [idString];
      await prefs.setStringList('id_list', newListIds);
      return;
    }
  }

  static Future<List<int>> getFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? idStrings = prefs.getStringList('id_list');
    return idStrings?.map((id) => int.parse(id)).toList() ?? [];
  }

  static Future<void> removeIdList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('id_list');
  }
}
