import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';
import 'package:breaking_bad/utilities/api_utilities.dart';

class CharactersWebServices {


  Future<List<Character>> fetchAllCharacters() async {
    List<Character> characters = [];

    String allCharactersAPI = base_api + all_characters_api;
    var response = await http.get(Uri.parse(allCharactersAPI));

    if (response.statusCode == 200) {

      print("Status Code Is:  ${response.statusCode}");

      var jsonData = jsonDecode(response.body) as List<dynamic>;
      characters = jsonData.map((e) => Character.fromJson(e as Map<String,dynamic>)).toList();

//      for (var item in jsonData) {
//        Character character = Character(
//          charId: item['char_id'],
//          name: item['name'],
//          birthday: item['birthday'],
//          occupation: item['occupation'],
//          img: item['img'],
//          status: item['status'],
//          nickname: item['nickname'],
//          appearance: item['appearance'],
//          portrayed: item['portrayed'],
//          category: item['category'],
//        );
//        characters.add(character);
//      }

      return characters;

    } else {
      print("Status Code Is:  ${response.statusCode}");
      return [];
    }
  }
}
