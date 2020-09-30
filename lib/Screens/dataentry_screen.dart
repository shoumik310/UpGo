import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upgo/Screens/home_screen.dart';
import 'package:upgo/components/rounded_button.dart';
import 'package:upgo/data.dart';
import 'package:intl/intl.dart';

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
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Please enter relevant details',
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
              ),
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
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    birthDate == null
                        ? 'Pick Date'
                        : DateFormat.yMd().format(birthDate),
                  ),
                  GestureDetector(
                    child: new Icon(Icons.calendar_today),
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
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton<String>(
                    value: type,
                    elevation: 16,
                    //Todo: style: ,
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
                  DropdownButton<String>(
                    value: iveness,
                    elevation: 16,
                    //Todo: style: ,
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
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: TextField(
                  controller: _textController,
                  textCapitalization: TextCapitalization.sentences,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    temp = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Condition',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            conditions.add(temp);
                          });
                          _textController.clear();
                        },
                      )),
                ),
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
                      background: Container(color: Colors.red),
                      child: ListTile(title: Text('$item')),
                    );
                  },
                ),
              ),
              RoundedButton(
                title: 'Submit',
                colour: Colors.lightBlueAccent,
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
                    signIn();
                    print(checkSignin());
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
