import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data_layer/models/character.dart';
import 'package:breaking_bad/data_layer/models/quote.dart';
import 'package:breaking_bad/data_layer/repository/quotes_repository.dart';
import 'package:meta/meta.dart';
import 'package:breaking_bad/data_layer/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository _charactersRepository;
  final QuotesRepository _quotesRepository;

  CharactersCubit(this._charactersRepository, this._quotesRepository)
      : super(CharactersInitial());

  void getAllCharacters() {
    _charactersRepository.fetchAllCharacters().then((value) {
      emit(CharactersLoaded(value));
    });
  }

  void getAllQuotes(String characterName) {
    _quotesRepository.fetchAllQuotes(characterName).then((value) {
      emit(QuotesLoaded(value));
    });
  }
}
