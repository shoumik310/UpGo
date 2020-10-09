import 'package:flutter/material.dart';

class FutureCard extends StatelessWidget {
  final Function getData;
  final bool isBirthDate;
  FutureCard({@required this.getData, this.isBirthDate = false});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getData(),
      builder: (context, snapshot) {
        Widget data;
        if (snapshot.hasData) {
          if (isBirthDate) {
            data = Text(
              (DateTime.now().difference(DateTime.parse(snapshot.data)).inDays /
                      365)
                  .floor()
                  .toString(),
              style: TextStyle(
                fontSize: 18,
              ),
            );
          } else {
            data = Text(
              snapshot.data,
              style: TextStyle(
                fontSize: 18,
              ),
            );
          }
        } else if (snapshot.hasError) {
          data = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.error_outline, color: Colors.red),
              Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          );
        } else {
          data = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(child: CircularProgressIndicator()),
              Text(
                'Awaiting Data',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          );
        }
        return Card(
          child: Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: data,
          ),
        );
      },
    );
  }
}
