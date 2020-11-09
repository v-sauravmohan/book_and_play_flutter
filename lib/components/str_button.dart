import 'package:book_and_play_flutter/constants.dart';
import 'package:flutter/material.dart';

class STRCTAButton extends StatelessWidget {
  final Color color;
  final Function onPress;
  final String buttonLabel;

  STRCTAButton({
    this.color,
    @required this.onPress,
    @required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: this.color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            this.onPress();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttonLabel,
            style: TextStyle(
              color: kPrimaryTextColor,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
