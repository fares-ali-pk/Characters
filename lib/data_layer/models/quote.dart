class Quote {

  String? quote;

  Quote({this.quote});

  Quote.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
  }
}
