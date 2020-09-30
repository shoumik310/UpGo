import 'package:shared_preferences/shared_preferences.dart';

class Data {
  addName(String name) async {
    SharedPreferences _data = await SharedPreferences.getInstance();
    _data.setString('name', name);
  }

  addAadhar(String aadhar) async {
    SharedPreferences _data = await SharedPreferences.getInstance();
    _data.setString('aadhar', aadhar);
  }

  addDate(String date) async {
    SharedPreferences _data = await SharedPreferences.getInstance();
    _data.setString('date', date);
  }

  addBlood(String bloodType) async {
    SharedPreferences _data = await SharedPreferences.getInstance();
    _data.setString('bloodType', bloodType);
  }

  addConditions(List<String> conditions) async {
    SharedPreferences _data = await SharedPreferences.getInstance();
    _data.setStringList('conditions', conditions);
  }

  signIn() async {
    SharedPreferences _data = await SharedPreferences.getInstance();
    _data.setBool('accountStatus', true);
  }

  signOut() async {
    SharedPreferences _data = await SharedPreferences.getInstance();
    _data.remove('accountStatus');
  }

  Future<bool> checkSignin() async {
    SharedPreferences _data = await SharedPreferences.getInstance();
    return _data.containsKey('accountStatus');
  }
}
