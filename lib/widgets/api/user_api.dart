import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_project/widgets/home/home_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class UserApi{


  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Future getUsers() async {

    final response = await http.get(Uri.https("jsonplaceholder.typicode.com","users"));
    var data = jsonDecode(response.body);
    List<MyObject> _users = [];

    for (var i in data) {
      MyObject user = MyObject(name: i['name'], username: i['username'], email: i['email']);
      _users.add(user);
    }

    return _users;
  }
}