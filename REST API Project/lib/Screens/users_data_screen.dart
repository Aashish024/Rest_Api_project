import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/UsersModel.dart';

class UsersDataScreen extends StatefulWidget {
  const UsersDataScreen({super.key});

  @override
  State<UsersDataScreen> createState() => _UsersDataScreenState();
}

class _UsersDataScreenState extends State<UsersDataScreen> {
  List<UsersModel> usersList = [];

  Future<List<UsersModel>> getUsersApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for (Map i in data){
        usersList.add(UsersModel.fromJson(i));
      }
      return usersList;
    }
    else{
      return usersList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Users Data'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUsersApi(),
                  builder: (context, AsyncSnapshot<List<UsersModel>> snapshot){
                    if(snapshot.hasData){
                return ListView.builder(
                    itemCount: usersList.length,
                    itemBuilder: (context, index){
                      return Card(
                        margin: const EdgeInsets.all(5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              ReusableRow(title: 'Name:', value: snapshot.data![index].name.toString()),
                              ReusableRow(title: 'Phone:', value: snapshot.data![index].phone.toString()),
                              ReusableRow(title: 'Email:', value: snapshot.data![index].email.toString()),
                              ReusableRow(title: 'City Address:', value: snapshot.data![index].address!.city.toString()),
                              ReusableRow(title: 'Lat:', value: snapshot.data![index].address!.geo!.lat.toString()),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text('Name: '),
                              //     Text(snapshot.data![index].name.toString())
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      );
                });
                    }
                    else{
                      return const Center(child: CircularProgressIndicator());
                    }
              })
          )
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title , value;
  const ReusableRow({super.key, required this.title, required this.value });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value)
        ],
      ),
    );
  }
}
