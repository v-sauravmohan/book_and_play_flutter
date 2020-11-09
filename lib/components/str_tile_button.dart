import 'package:book_and_play_flutter/constants.dart';
import 'package:flutter/material.dart';

class STRTileButton extends StatelessWidget {
  final Function onPress;
  final String label;
  final IconData icon;

  STRTileButton({
    this.onPress,
    this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Material(
          elevation: 5.0,
          color: kDarkPrimaryColor,
          borderRadius: BorderRadius.circular(20.0),
          child: MaterialButton(
            onPressed: () {
              this.onPress();
            },
            minWidth: 50,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.black,
                  size: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  label,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
