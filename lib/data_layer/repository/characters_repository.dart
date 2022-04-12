import '../web_services/characters_web_services.dart';
import '../models/character.dart';

class CharactersRepository {
  late final CharactersWebServices _charactersWebServices;

  CharactersRepository(this._charactersWebServices);

  Future<List<Character>> fetchAllCharacters() async =>
      await _charactersWebServices.fetchAllCharacters();

}
