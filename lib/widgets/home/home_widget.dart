
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/widgets/api/user_api.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  List<MyObject> _myList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<MyObject> list = List.from(data.map((i) => MyObject.fromJson(i)));
      setState(() {
        _myList = list;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: UserApi.getUsers(),
            builder: (context, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  ),
                );
              } else if (data.data == null) {
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.warning_amber_outlined,
                            color: Colors.deepPurple, size: 120),
                        SizedBox(height: 30),
                        Text(
                          "Не удалось загрузить информацию",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ))),
                              child: Text(
                                "Обновить",
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                var items = data.data as List<MyObject>;
                return Scaffold(
                  body: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar.medium(
                        automaticallyImplyLeading: false,
                        centerTitle: true,
                        title: Text("Пользователи"),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final item = _myList[index];
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 75,
                                    ),
                                    SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          items[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          items[index].email,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                        Text(
                                          items[index].username,
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: _myList.length,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MyObject {
  final String name;
  final String username;
  final String email;

  factory MyObject.fromJson(Map<String, dynamic> json) {
    return MyObject(
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  MyObject({required this.name, required this.username, required this.email});

}