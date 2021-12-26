import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyMotivators extends StatelessWidget {
  const EmptyMotivators({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    final double _screenWidth = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left -
        MediaQuery.of(context).padding.right;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Center(
              heightFactor: 0.7,
              child: SvgPicture.asset(
                'assets/images/empty.svg',
                width: _screenWidth * 0.65,
              ),
            ),
            Container(
              height: 250,
              color: const Color.fromRGBO(255, 255, 255, 0.7),
            ),
            const Align(
              alignment: Alignment(0.12, 0),
              heightFactor: 1.6,
              child: Text(
                'Empty',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: Colors.black45,
                  fontSize: 30,
                ),
                textWidthBasis: TextWidthBasis.parent,
              ),
            ),
            const Align(
              alignment: Alignment(0, 0.12),
              heightFactor: 10,
              // heightFactor: 12.5,
              child: Text(
                'Add some motivators',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: Colors.black45,
                  fontSize: 28,
                ),
                textWidthBasis: TextWidthBasis.parent,
              ),
            )
          ],
        ),
      ],
    );
  }
}
