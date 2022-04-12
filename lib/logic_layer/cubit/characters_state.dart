part of 'characters_cubit.dart';




@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  List<Character> _characters;

  CharactersLoaded(this._characters);

  List<Character> get characters => _characters;
}

class QuotesLoaded extends CharactersState {
  List<Quote> _quotes;

  QuotesLoaded(this._quotes);

  List<Quote> get quotes => _quotes;


}

