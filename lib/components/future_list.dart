import 'package:flutter/material.dart';
import 'package:upgo/data.dart';

class FutureList extends StatelessWidget {
  final Function getData;
  FutureList(this.getData);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getData(),
      builder: (context, snapshot) {
        Widget name;
        if (snapshot.hasData) {
          List<String> temp = snapshot.data;
          name = ListView.builder(
              itemCount: temp.length,
              itemBuilder: (context, index) {
                return Text(temp[index]);
              });
        } else if (snapshot.hasError) {
          name = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Icon(Icons.error_outline, color: Colors.red),
              Text('Error: ${snapshot.error}'),
            ],
          );
        } else {
          name = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(child: CircularProgressIndicator()),
              Text('Awaiting Data'),
            ],
          );
        }
        return Card(child: name);
      },
    );
  }
}
