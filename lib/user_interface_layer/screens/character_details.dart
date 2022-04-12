import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/data_layer/models/character.dart';
import 'package:breaking_bad/data_layer/models/quote.dart';
import 'package:breaking_bad/logic_layer/cubit/characters_cubit.dart';
import 'package:breaking_bad/utilities/my_colors.dart';
import 'package:breaking_bad/utilities/widget_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breaking_bad/data_layer/repository/characters_repository.dart';
import 'package:breaking_bad/data_layer/repository/quotes_repository.dart';
import 'package:breaking_bad/data_layer/web_services/characters_web_services.dart';
import 'package:breaking_bad/data_layer/web_services/quotes_web_services.dart';

class CharacterDetails extends StatefulWidget {
  final Character character;

  const CharacterDetails({Key? key, required this.character}) : super(key: key);

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  List<Quote> quotes = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        //BlocProvider.of<CharactersCubit>(context).getAllQuotes(widget.character.name);
        return CharactersCubit(
          CharactersRepository(CharactersWebServices()),
          QuotesRepository(QuotesWebServices()),
        );
      },
      child: Scaffold(
        backgroundColor: MyColor.myGrey,
        body: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    color: MyColor.myGrey,
                    margin: const EdgeInsets.all(16.0),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _drawInformation(),
                        const SizedBox(
                          height: 128,
                        ),
                        _drawQuote(widget.character.name),
                        const SizedBox(
                          height: 128,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      leading: const BackButton(
        color: MyColor.myYellow,
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.80,
      pinned: true,
      stretch: true,
      backgroundColor: MyColor.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.character.nickname,
          style: const TextStyle(
            color: MyColor.myWhite,
          ),
        ),
        background: Hero(
          tag: widget.character.charId,
          child: widget.character.img.isNotEmpty
              ? ((widget.character.img == "assets/images/fares.jpg")
              ? Image.asset("assets/images/fares.jpg" ,fit: BoxFit.cover,)
              : FadeInImage.assetNetwork(
            placeholder: 'assets/images/loading.gif',
            image: widget.character.img,
            fit: BoxFit.cover,
          ))
              : Image.asset('assets/images/noimage.gif'),
        ),
      ),
    );
  }

  Widget _drawInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _showDetails("Actor/Actress : ", widget.character.portrayed),
        _drawDivider(208),
        _showDetails("birthday : ", widget.character.birthday),
        _drawDivider(258),
        _showDetails("Job : ", widget.character.occupation.join(' / ')),
        _drawDivider(290),
        _showDetails("Appeared in : ", widget.character.category),
        _drawDivider(224),
        _showDetails("Seasons : ", widget.character.appearance.join(' - ')),
        _drawDivider(254),
        _showDetails("Status : ", widget.character.status),
        _drawDivider(270),
      ],
    );
  }

  Widget _showDetails(String title, var value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            color: MyColor.myWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            color: MyColor.myWhite,
            fontSize: 16,
          ),
        ),
      ]),
    );
  }

  Widget _drawDivider(double length) {
    return Divider(
      height: 30,
      thickness: 2,
      color: MyColor.myYellow,
      endIndent: length.toDouble(),
    );
  }

  Widget _drawQuote(String characterName) {
    return Builder(
      builder: (context) {
        context.read<CharactersCubit>().getAllQuotes(characterName);
        return BlocBuilder<CharactersCubit, CharactersState>(
            builder: (context, state) {
          if (state is QuotesLoaded) {
            quotes = (state).quotes;
            return _showRandomQuote();
          } else {
            return loading();
          }
        });
      },
    );
  }

  Widget _showRandomQuote() {
    if (quotes.isEmpty) {
      return const Text(
        "There is no quotes for this character",
        style: TextStyle(
          color: MyColor.myYellow,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          wordSpacing: 2,
        ),
        textAlign: TextAlign.center,
      );
    } else {
      int random = Random().nextInt(quotes.length - 1);
      String quote = quotes[random].quote!;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: DefaultTextStyle(
            style: const TextStyle(
              fontSize: 24.0,
              color: MyColor.myYellow,
              letterSpacing: 1,
              wordSpacing: 2,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  quote,
                  speed: const Duration(milliseconds: 75),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
