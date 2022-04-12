import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/quote.dart';
import 'package:breaking_bad/utilities/api_utilities.dart';

class QuotesWebServices{

  Future<dynamic> fetchAllQuotes (String characterName) async {
    List<Quote> quotes = [];

    String nameAPI = characterName.replaceAll(" ", '+');
    String allQuotesAPI = base_api + quotes_api + nameAPI;
    var response = await http.get(Uri.parse(allQuotesAPI));

    if (response.statusCode == 200) {

      var jsonData = jsonDecode(response.body);

      for(var item in jsonData){
        Quote quote =Quote(quote: item['quote']);
        quotes.add(quote);
      }

      return quotes;

    } else {
      print("Status Code Is:  ${response.statusCode}");
      return [];
    }
  }

}