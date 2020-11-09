import 'package:flutter/material.dart';

const kDarkPrimaryColor = Color(0xFF689F38);
const kLightPrimaryColor = Color(0xFFDCEDC8);
const kPrimaryColor = Color(0xFF8BC34A);
const kTextIconsColor = Color(0xFF212121);
const kAccentColor = Color(0xFF9E9E9E);
const kPrimaryTextColor = Color(0xFF212121);
const kSecondaryTextColor = Color(0xFF757575);
const kDividerColor = Color(0xFFBDBDBD);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: kSecondaryTextColor,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kAccentColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kAccentColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kDefaultMessageBubbleBorder = BorderRadius.only(
  topLeft: Radius.circular(30.0),
  bottomLeft: Radius.circular(30.0),
  bottomRight: Radius.circular(30.0),
);

const kMeMessageBubbleBorder = BorderRadius.only(
  topRight: Radius.circular(30.0),
  topLeft: Radius.circular(30.0),
  bottomRight: Radius.circular(30.0),
);
