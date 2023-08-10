import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rest_api_project/Models/PostsModel.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_project/Screens/data_screen.dart';
import 'package:rest_api_project/Screens/product_data_screen.dart';
import 'package:rest_api_project/Screens/users_data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<PostsModel> postList = [];
  Future<List<PostsModel>> getApiModel() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode== 200){
      for (Map i in data){
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    }
    else{
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              const UserAccountsDrawerHeader(
                  accountName: Text('Aashish'),
                  accountEmail: Text('aashish.batra132@gmail.com'),
              ),
              ListTile(
                leading: const Icon(Icons.medical_information),
                title: const Text('Data'),
                trailing: const Icon(Icons.arrow_forward_outlined),
                onTap: (){
                  Get.to(()=> const DataScreen());
                },
              ),
              ListTile(
                leading: const Icon(Icons.medical_information),
                title: const Text('Personal Data'),
                trailing: const Icon(Icons.arrow_forward_outlined),
                onTap: (){
                  Get.to(()=> const UsersDataScreen());
                },
              ),
              ListTile(
                leading: const Icon(Icons.medical_information),
                title: const Text('Products Data'),
                trailing: const Icon(Icons.arrow_forward_outlined),
                onTap: (){
                  Get.to(()=> const ProductDataScreen());
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getApiModel(),
                builder: (context, snapshot){
                if(!snapshot.hasData){
                  return const Center(child: Text('Loading...'));
                }
                else{
                  return ListView.builder(
                    itemCount: postList.length,
                      itemBuilder: (context,index){
                    return Card(
                      elevation: 5.0,
                      margin: const EdgeInsets.all(5.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Title:' ,style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(postList[index].title.toString()),
                            const SizedBox(height: 5.0,),
                            const Text('Description:' ,style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(postList[index].body.toString()),
                          ],
                        ),
                      ),
                    );
                  });
                }
                //return Container(child: Text("wrong"),);
            }
            ),
          ),
        ],
      )
    );
  }
}
