import 'package:breaking_bad/data_layer/models/character.dart';
import 'package:breaking_bad/utilities/my_colors.dart';
import 'package:breaking_bad/utilities/widget_utilities.dart';
import 'package:flutter/material.dart';
import 'package:breaking_bad/logic_layer/cubit/characters_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/character_widget.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final Character _fares = Character(
    charId: 0,
    name: "Kirito Kirigaya",
    birthday: "01/01/1998",
    occupation: ["Mobile Developer"],
    img: "assets/images/fares.jpg",
    status: "Alive",
    nickname: "Scarlet Knight",
    appearance: [1, 2, 3, 4, 5],
    portrayed: "Fares Ali Pk",
    category: "IT Engineer",
  );

  List<Character> _allCharacters = [];

  List<Character> _searchOfCharacters = [];

  late TextEditingController _searchTextController;

  bool _isSearching = false;

  bool _isEmpty = false;

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
    //_allCharacters.clear();
    //_allCharacters.add(_fares);
    //context.read<CharactersCubit>().getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _isSearching
          ? Container()
          : const Drawer(
              backgroundColor: MyColor.myGrey,
            ),
      body: _buildBlocWidget(),
    );
  }

  Widget _buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          _allCharacters = [];
          _allCharacters.add(_fares);
          _allCharacters.addAll((state).characters);

          return _buildNetOfCharacters();
        } else {
          print("state is not character loaded");
          return loading();
        }
      },
    );
  }

  Widget _buildNetOfCharacters() {

    return Container(
      color: MyColor.myGrey,
      child: _isEmpty
          ? _noCharacter()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1),
              itemBuilder: (context, index) {
                return CharacterWidget(
                    character: _searchTextController.text.isNotEmpty
                        ? _searchOfCharacters[index]
                        : _allCharacters[index]);
              },
              //shrinkWrap: true,
              //physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: _searchTextController.text.isNotEmpty
                  ? _searchOfCharacters.length
                  : _allCharacters.length,
            ),
    );
  }

  AppBar _buildAppBar() {
    if (_isSearching) {
      return AppBar(
        toolbarOpacity: 0.55,
        backgroundColor: MyColor.myYellow,
        actions: [
          Expanded(
            child: _searchWidget(),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  _searchTextController.clear();
                  _searchOfCharacters = [];
                  _isSearching = false;
                  _isEmpty = false;
                });
              },
              icon: const Icon(
                Icons.clear,
                color: MyColor.myGrey,
              )),
        ],
      );
    } else {
      return AppBar(
        backgroundColor: MyColor.myYellow,
        title: const Text(
          "Characters",
          style: TextStyle(color: MyColor.myGrey),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
              icon: const Icon(
                Icons.search,
                color: MyColor.myGrey,
              ))
        ],
      );
    }
  }

  Widget _searchWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 56, top: 4, bottom: 4),
      child: TextField(
        controller: _searchTextController,
        cursorColor: MyColor.myGrey,
        autofocus: true,
        toolbarOptions: const ToolbarOptions(
            copy: true, cut: true, paste: true, selectAll: true),
        decoration: const InputDecoration(
          hintText: "Find a character ...",
          border: InputBorder.none,
          hintStyle: TextStyle(
              color: MyColor.myGrey, fontSize: 18, fontWeight: FontWeight.w300),
        ),
        style: const TextStyle(color: MyColor.myGrey, fontSize: 18),
        onChanged: (inputChar) {
          setState(() {
            _searchOfCharacters = _allCharacters
                .where((character) =>
                    character.name.toLowerCase().startsWith(inputChar.toLowerCase()))
                .toList();
            _isEmpty = _searchOfCharacters.isEmpty ? true : false;
          });
        },
      ),
    );
  }

  Widget _noCharacter() {
    return const Center(
      child: Text(
        "There is no character with this name!!!",
        style: TextStyle(
          color: MyColor.myYellow,
          fontSize: 26,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          wordSpacing: 1.5,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
