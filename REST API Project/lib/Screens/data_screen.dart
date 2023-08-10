import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {

  List<Photos> photosList =[];
  Future<List<Photos>> getPhotos() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    }
    else{
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot){
                if(snapshot.hasData){
              return ListView.builder(
                itemCount: photosList.length,
                  itemBuilder: (context, index){
                return Card(
                  margin: const EdgeInsets.all(5.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                    ),
                    title: Text('Id: '+snapshot.data![index].id.toString()),
                    subtitle: Text('Title: '+snapshot.data![index].title.toString()),
                  ),
                );
              });}
                else{
                  return const Center(child: Text('Loading...'));
                }
            }),
          )
        ],
      ),
    );
  }
}

class Photos{
  String title, url;
  int id;

  Photos({required this.title, required this.url, required this.id});
}