import 'package:flutter/material.dart';

class BookAndPlayCTAButton extends StatelessWidget {
  final Color color;
  final Function onPress;
  final String buttonLabel;

  BookAndPlayCTAButton({
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
          child: Text(buttonLabel),
        ),
      ),
    );
  }
}
