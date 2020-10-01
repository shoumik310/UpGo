import 'package:shared_preferences/shared_preferences.dart';

void addName(String name) async {
  SharedPreferences _data = await SharedPreferences.getInstance();
  _data.setString('name', name);
}

void addAadhar(String aadhar) async {
  SharedPreferences _data = await SharedPreferences.getInstance();
  _data.setString('aadhar', aadhar);
}

void addDate(String date) async {
  SharedPreferences _data = await SharedPreferences.getInstance();
  _data.setString('date', date);
}

void addBlood(String bloodType) async {
  SharedPreferences _data = await SharedPreferences.getInstance();
  _data.setString('bloodType', bloodType);
}

void addConditions(List<String> conditions) async {
  SharedPreferences _data = await SharedPreferences.getInstance();
  _data.setStringList('conditions', conditions);
}

//signIn() async {
//  SharedPreferences _data = await SharedPreferences.getInstance();
//  _data.setBool('accountStatus', true);
//}

//signOut() async {
//  SharedPreferences _data = await SharedPreferences.getInstance();
//  _data.remove('accountStatus');
//}

Future<String> getName() async {
  SharedPreferences _data = await SharedPreferences.getInstance();
  String info = _data.getString('name');
  return info;
}

Future<String> getAadhar() async {
  SharedPreferences _data = await SharedPreferences.getInstance();
  String info = _data.getString('aadhar');
  return info;
}

Future<String> getDate() async {
  SharedPreferences _data = await SharedPreferences.getInstance();
  String info = _data.getString('date');
  return info;
}

Future<String> getBlood() async {
  SharedPreferences _data = await SharedPreferences.getInstance();
  String info = _data.getString('bloodType');
  return info;
}

Future<List<String>> getConditions() async {
  SharedPreferences _data = await SharedPreferences.getInstance();
  List<String> info = _data.getStringList('conditions');
  return info;
}

removeAll() async {
  SharedPreferences _data = await SharedPreferences.getInstance();
  _data.clear();
}
