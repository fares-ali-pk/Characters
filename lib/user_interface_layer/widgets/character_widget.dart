import 'package:breaking_bad/data_layer/models/character.dart';
import 'package:breaking_bad/utilities/my_colors.dart';
import 'package:flutter/material.dart';
import '../screens/character_details.dart';

class CharacterWidget extends StatelessWidget {
  final Character character;

  const CharacterWidget({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: MyColor.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CharacterDetails(character: character)));
        },
        child: Hero(
          tag: character.charId,
          child: GridTile(
            child: Container(
              //padding: const EdgeInsets.all(8),
              color: MyColor.myGrey,
              child: character.img.isNotEmpty
                  ? ((character.img == "assets/images/fares.jpg")
                      ? Image.asset("assets/images/fares.jpg" ,fit: BoxFit.cover,)
                      : FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image: character.img,
                          fit: BoxFit.cover,
                        ))
                  : Image.asset('assets/images/noimage.gif'),
            ),
            footer: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColor.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
