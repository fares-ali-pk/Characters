import '../models/quote.dart';
import '../web_services/quotes_web_services.dart';

class QuotesRepository {
  final QuotesWebServices _quotesWebServices;

  QuotesRepository(this._quotesWebServices);

  Future<List<Quote>> fetchAllQuotes(String characterName) async =>
      await _quotesWebServices.fetchAllQuotes(characterName);
}
