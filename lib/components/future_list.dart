import 'package:flutter/material.dart';
import '../constants.dart';

class FutureList extends StatelessWidget {
  final Function getData;
  FutureList(this.getData);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<String>>(
        future: getData(),
        builder: (context, snapshot) {
          Widget condition;
          if (snapshot.hasData) {
            List<String> temp = snapshot.data;
            condition = ListView.builder(
                itemCount: temp.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                      Text(
                        temp[index],
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            condition = Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(Icons.error_outline, color: Colors.red),
                Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          } else {
            condition = Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(child: CircularProgressIndicator()),
                Text(
                  'Awaiting Data',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          }
          return Card(
            child: condition,
            color: kBackgroundColor,
          );
        },
      ),
    );
  }
}
