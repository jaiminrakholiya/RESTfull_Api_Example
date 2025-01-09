import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SamplePosts> samplePostes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot) {

          if(snapshot.hasData){
            return ListView.builder(
              itemCount: samplePostes.length, // Number of items in the list
              itemBuilder: (context, index) {
                return Container(
                    height: 125,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: const EdgeInsets.all(10),
                    color: Colors.greenAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'User id: ${samplePostes[index].userId}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Id:  ${samplePostes[index].id}',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Title:  ${samplePostes[index].title}',
                          maxLines: 1,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          'Body:  ${samplePostes[index].body}',
                          style: TextStyle(fontSize: 18),
                          maxLines:1,
                        ),
                      ],
                    ));
              },
            );
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }

  Future<List<SamplePosts>> getData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for(Map<String,dynamic> index in data){
        samplePostes.add(SamplePosts.fromJson(index));
      }
      return samplePostes;
    }else{
      return samplePostes;
    }
  }
}
