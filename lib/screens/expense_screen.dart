import 'package:book_and_play_flutter/components/str_button.dart';
import 'package:book_and_play_flutter/streams/expense_stream.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../constants.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class ExpenseScreen extends StatefulWidget {
  static String id = 'expense_screen';
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final _auth = FirebaseAuth.instance;
  String _username;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
      await _firestore
          .collection('users')
          .where('email', isEqualTo: loggedInUser.email)
          .get()
          .then((value) => value.docs.isEmpty
              ? _username = 'Unknown User'
              : _username = value.docs.single.get('username'));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        iconTheme: IconThemeData(
          color: kTextIconsColor,
          size: 30,
        ),
        title: Text(
          'Expenses',
          style: TextStyle(
            letterSpacing: 2,
            color: kPrimaryTextColor,
            fontSize: 30,
            fontFamily: 'League Gothic',
          ),
        ),
        backgroundColor: kDarkPrimaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: kTextIconsColor,
          size: 30,
        ),
        onPressed: () {
          print('clicked');
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddExpenseForm(
                username: _username,
                fireStoreInstance: _firestore,
              );
            },
          );
        },
        backgroundColor: Colors.lightGreen,
        focusColor: Colors.green,
        hoverColor: Colors.green[700],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10.0),
            Center(
              child: Text(
                '\$1000/-',
                style: TextStyle(fontSize: 70),
              ),
            ),
            Divider(
              thickness: 1,
              color: kDividerColor,
              height: 1,
            ),
            ExpenseStream(
              fireStoreInstance: _firestore,
            ),
          ],
        ),
      ),
    );
  }
}

class AddExpenseForm extends StatefulWidget {
  final String username;
  final FirebaseFirestore fireStoreInstance;
  AddExpenseForm({this.username, @required this.fireStoreInstance});
  @override
  _AddExpenseFormState createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  String _expenseTitle;
  String _expenseDescription;
  String _expenseCategory;
  String _expenseAmount;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      content: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Add Expense',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  style: TextStyle(
                    color: kPrimaryTextColor,
                  ),
                  decoration: kMessageTextFieldDecoration.copyWith(
                    icon: Icon(Icons.title),
                    labelText: 'Title *',
                    hintText: '',
                  ),
                  onChanged: (value) {
                    _expenseTitle = value;
                  },
                  validator: RequiredValidator(errorText: 'Title is required'),
                ),
                TextFormField(
                  style: TextStyle(
                    color: kPrimaryTextColor,
                  ),
                  decoration: kMessageTextFieldDecoration.copyWith(
                    icon: Icon(Icons.description),
                    labelText: 'Description *',
                    hintText: '',
                  ),
                  onChanged: (value) {
                    _expenseDescription = value;
                  },
                  validator:
                      RequiredValidator(errorText: 'Description is required'),
                ),
                DropdownButtonFormField(
                  value: _expenseCategory,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24.0,
                  elevation: 10,
                  style: TextStyle(color: Colors.black),
                  decoration: kMessageTextFieldDecoration.copyWith(
                    icon: Icon(Icons.category),
                    labelText: 'Category *',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _expenseCategory = value;
                    });
                  },
                  items: ['Maintenance', 'Sports Goods', 'Food and Water']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator:
                      RequiredValidator(errorText: 'Category is required'),
                ),
                TextFormField(
                  style: TextStyle(
                    color: kPrimaryTextColor,
                  ),
                  onChanged: (value) {
                    _expenseAmount = value;
                  },
                  keyboardType: TextInputType.number,
                  decoration: kMessageTextFieldDecoration.copyWith(
                    icon: Icon(Icons.attach_money),
                    hintText: '',
                    labelText: 'Amount *',
                  ),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  validator: RequiredValidator(errorText: 'Amount is required'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: STRCTAButton(
                    buttonLabel: "Submit",
                    color: kAccentColor,
                    onPress: () {
                      if (_formKey.currentState.validate()) {
                        widget.fireStoreInstance.collection('expenses').add({
                          'expenseTitle': _expenseTitle,
                          'expenseDescription': _expenseDescription,
                          'expenseCategory': _expenseCategory,
                          'expenseAmount': _expenseAmount,
                          'dateTime': DateTime.now(),
                          'username': widget.username,
                        });
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
