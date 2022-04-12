import 'package:breaking_bad/user_interface_layer/widgets/no_connection_widget.dart';
import 'package:breaking_bad/utilities/widget_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import 'data_layer/repository/characters_repository.dart';
import 'data_layer/repository/quotes_repository.dart';
import 'data_layer/web_services/characters_web_services.dart';
import 'user_interface_layer/screens/characters_screen.dart';
import 'logic_layer/cubit/characters_cubit.dart';
import 'package:breaking_bad/data_layer/web_services/quotes_web_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  late final CharactersRepository _charactersRepository;

  late final QuotesRepository _quotesRepository;

  late final CharactersCubit _charactersCubit;

  MyApp({Key? key}) : super(key: key) {
    _charactersRepository = CharactersRepository(CharactersWebServices());
    _quotesRepository = QuotesRepository(QuotesWebServices());
    _charactersCubit =
        CharactersCubit(_charactersRepository, _quotesRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => _charactersCubit,
        child: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              //print("if : $connected");
              return const CharactersScreen();
            } else {
              //print("else : $connected");
              return const NoConnectionWidget();
    }
          },
          child: loading(),
        ),
      ),
    );
  }
}
