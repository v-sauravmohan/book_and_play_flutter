import 'package:book_and_play_flutter/components/str_expense_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExpenseStream extends StatelessWidget {
  final FirebaseFirestore fireStoreInstance;

  ExpenseStream({@required this.fireStoreInstance});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fireStoreInstance.collection('expenses').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ),
            );
          }
          final expenses = snapshot.data.docs;
          List<STRExpenseCard> expenseCards = [];
          for (var expense in expenses) {
            final expenseTitle = expense.get('expenseTitle');
            final username = expense.get('username');
            final expenseDescription = expense.get('expenseDescription');
            final expenseCategory = expense.get('expenseCategory');
            final expenseAmount = expense.get('expenseAmount');
            final dateTime = expense.get('dateTime');
            final expenseCard = STRExpenseCard(
              title: expenseTitle,
              username: username,
              description: expenseDescription,
              category: expenseCategory,
              amount: expenseAmount,
              dateTime: dateTime,
            );
            expenseCards.add(expenseCard);
          }
          expenseCards.sort((a, b) => b.dateTime.compareTo(a.dateTime));
          return Flexible(
            child: ListView(
              reverse: false,
              shrinkWrap: false,
              padding: EdgeInsets.only(
                left: 5.0,
                right: 5.0,
                bottom: 5.0,
              ),
              children: expenseCards,
            ),
          );
        });
  }
}
