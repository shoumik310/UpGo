import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upgo/Screens/home_screen.dart';
import 'package:upgo/components/rounded_button.dart';
import 'package:upgo/data.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class DataEntryScreen extends StatefulWidget {
  static const String id = 'dataentry_screen';

  @override
  _DataEntryScreenState createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  String name;
  DateTime birthDate;
  String bloodGroup, type = "A", iveness = "+";
  List<String> conditions = <String>[];
  String temp;
  String aadhar;
  TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Icon(
              Icons.keyboard,
              size: 40,
            ),
          ),
          backgroundColor: kBackgroundColor,
          centerTitle: true,
          title: BorderedText(
            strokeWidth: 5,
            strokeColor: Colors.white,
            child: Text(
              'Please enter details given below ',
              style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.bold,
                  color: kBackgroundColor),
            ),
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                  textCapitalization: TextCapitalization.words,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Enter Name')),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                  maxLength: 12,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    aadhar = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Aadhar Number')),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        birthDate == null
                            ? 'Select BirthDate'
                            : DateFormat.yMd().format(birthDate),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        child: new Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          final datePick = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1910),
                              lastDate: DateTime.now());
                          if (datePick != null) {
                            setState(() {
                              birthDate = datePick;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(12.0))),
                        child: DropdownButton<String>(
                          style: TextStyle(color: kBackgroundColor),
                          value: type,
                          elevation: 16,
                          onChanged: (value) {
                            setState(() {
                              type = value;
                            });
                          },
                          items: <String>[
                            "A",
                            "B",
                            "O",
                            "AB",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(12.0))),
                        child: DropdownButton<String>(
                          value: iveness,
                          elevation: 16,
                          onChanged: (value) {
                            iveness = value;
                          },
                          items: <String>[
                            "+",
                            "-",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _textController,
                  textCapitalization: TextCapitalization.sentences,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    temp = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter Condition',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            conditions.add(temp);
                          });
                          _textController.clear();
                        },
                      ))),
              SizedBox(
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              Text(
                conditions.length != 0
                    ? 'Entered Conditions (Swipe to dismiss):'
                    : '',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PlayfairDisplay',
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: conditions.length,
                  itemBuilder: (context, index) {
                    String item = conditions[index];
                    return Dismissible(
                      key: Key(item),
                      onDismissed: (direction) {
                        setState(() {
                          conditions.removeAt(index);
                        });
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("$item removed")));
                      },
                      background: Container(color: Colors.grey),
                      child: ListTile(
                          title: Text(
                        '$item',
                        style: TextStyle(color: Colors.white),
                      )),
                    );
                  },
                ),
              ),
              RoundedButton(
                title: 'Submit',
                buttonColour: kBackgroundColor,
                textColour: Colors.white,
                borderColour: Colors.white,
                onPressed: () {
                  if (name != null &&
                      aadhar != null &&
                      birthDate != null &&
                      type != null &&
                      iveness != null) {
                    addName(name);
                    addAadhar(aadhar);
                    addDate(birthDate.toString());
                    addBlood(type + iveness);
                    if (conditions.length == 0) {
                      conditions.add("No Known Conditions");
                    }
                    addConditions(conditions);
                    Navigator.pushNamed(context, HomeScreen.id);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Entry Incomplete'),
                            content: Text('Please Enter All Required Details'),
                          );
                        });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

//(DateTime.now().difference(birthDate).inDays / 365).floor().toString()
