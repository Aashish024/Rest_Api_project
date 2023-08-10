import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/ProductsModel.dart';

class ProductDataScreen extends StatefulWidget {
  const ProductDataScreen({super.key});

  @override
  State<ProductDataScreen> createState() => _ProductDataScreenState();
}

class _ProductDataScreenState extends State<ProductDataScreen> {

  Future<ProductsModel> getProductApi() async{
    final response = await http.get(Uri.parse('https://webhook.site/cd3f6962-362c-488b-b494-b2f6fc89b9ea'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode== 200){
     return ProductsModel.fromJson(data);
    }
    else{
      return ProductsModel.fromJson(data);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Data'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<ProductsModel>(
                  future: getProductApi(),
                  builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data!.data![index].shop!.image.toString()),
                                ),
                                title: Text(snapshot.data!.data![index].shop!.name.toString()),
                                subtitle: Text(snapshot.data!.data![index].shop!.shopemail.toString()),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height *.3,
                                width: MediaQuery.of(context).size.width *1,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.data![index].images!.length,
                                    itemBuilder: (context, position){
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height * .25,
                                      width: MediaQuery.of(context).size.width * .5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())
                                        )
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              Icon(snapshot.data!.data![index].inWishlist! == false ? Icons.favorite : Icons.favorite_border_outlined)
                            ],
                          );
                    });
                  }
                  else{
                    return const Center(child: Text('Loading...'));
                  }
                },
                )
            )
          ],
        ),
      ),
    );
  }
}