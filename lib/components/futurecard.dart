import 'package:flutter/material.dart';
import 'package:upgo/data.dart';

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
            data = Text((DateTime.now()
                        .difference(DateTime.parse(snapshot.data))
                        .inDays /
                    365)
                .floor()
                .toString());
          } else {
            data = Text(snapshot.data);
          }
        } else if (snapshot.hasError) {
          data = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.error_outline, color: Colors.red),
              Text('Error: ${snapshot.error}'),
            ],
          );
        } else {
          data = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(child: CircularProgressIndicator()),
              Text('Awaiting Data'),
            ],
          );
        }
        return Card(child: data);
      },
    );
  }
}
