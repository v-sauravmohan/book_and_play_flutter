import 'package:book_and_play_flutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:book_and_play_flutter/extensions/stringextensions.dart';

class STRExpenseCard extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String username;
  final String amount;
  final Timestamp dateTime;

  STRExpenseCard(
      {this.title,
      this.username,
      this.description,
      this.category,
      this.amount,
      this.dateTime});

  Widget switchIcon(String category) {
    Widget icon;
    switch (category) {
      case 'Maintenance':
        {
          icon = Icon(
            Icons.gavel,
            size: 30.0,
            color: kTextIconsColor,
          );
        }
        break;
      case 'Sports Goods':
        {
          icon = Icon(
            Icons.directions_run,
            size: 30.0,
            color: kTextIconsColor,
          );
        }
        break;
      case 'Food and Water':
        {
          icon = Icon(
            Icons.restaurant,
            size: 30.0,
            color: kTextIconsColor,
          );
        }
        break;
      default:
        {
          icon = Icon(
            Icons.attach_money,
            size: 30.0,
            color: kTextIconsColor,
          );
        }
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Container(
                child: switchIcon(category),
              ),
              title: Text(
                title.capitalize(),
                style: TextStyle(
                  color: kPrimaryTextColor,
                  fontSize: 30.0,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 10.0,
                  ),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kSecondaryTextColor,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '\$ $amount',
                        style: TextStyle(
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 5.0),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kSecondaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'by',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: kSecondaryTextColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 5.0),
                      child: Text(
                        username,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: kSecondaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
    );
  }
}
