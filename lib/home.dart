import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _posts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newsroom'),
        backgroundColor: Color.fromARGB(255, 40, 122, 96),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                color: Color.fromARGB(255, 36, 116, 156),
                height: 100,
                width: 100,
                child: _posts[index]['urlToImage'] != null
                    ? Image.network(_posts[index]['urlToImage'])
                    : const Center(),
              ),
              title: Text('${_posts[index]['title']}'),
              subtitle: Text('${_posts[index]['author']}'),
              // onTap: () {
              //   Navigator.push(
              //       context, MaterialPageRoute(builder: (c) => const Detail()));
              // },
            );
          }),
    );
  }

  Future _getData() async {
    try {
      const baseUrl =
          'https://newsapi.org/v2/top-headlines?country=id&category=business&apiKey=8630b7cbc7ce47dda57052ae1623fe22';
      final response = await http.get(Uri.parse(baseUrl));
      // final response = await http.get(
      //     'https://newsapi.org/v2/everything?q=tesla&from=2023-06-09&sortBy=publishedAt&apiKey=8630b7cbc7ce47dda57052ae1623fe22');
      if (response.statusCode == 200) {
        // print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          _posts = data['articles'];
        });
        print(_posts);
      }
    } catch (e) {
      print(e);
    }
  }
}
