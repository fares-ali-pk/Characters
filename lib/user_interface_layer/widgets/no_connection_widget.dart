import 'package:breaking_bad/utilities/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoConnectionWidget extends StatefulWidget {
  const NoConnectionWidget({Key? key}) : super(key: key);

  @override
  _NoConnectionWidgetState createState() => _NoConnectionWidgetState();
}

class _NoConnectionWidgetState extends State<NoConnectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              child: SvgPicture.asset(
                "assets/images/no_internet.svg",
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: 128.0,
              left: 8.0,
              right: 8.0,
            ),
            child: Text(
              "No Internet ..... Please Check Your Connention",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MyColor.myGrey,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
