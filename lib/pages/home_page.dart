import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/widgets/home_widgets/catalog_header.dart';
import 'package:flutter_catalog/widgets/home_widgets/catalog_list.dart';
import 'package:flutter_catalog/widgets/themes.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';

import '../utils/routes.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;

  final String name = "Codepur";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    final catalogJson = await rootBundle.loadString('assets/catalog.json');
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData['products'];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.creamColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
        backgroundColor: MyTheme.darkBluishColor,
        child: Icon(CupertinoIcons.cart),
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatelogHeader(),
              if (CatalogModel.items != null && CatalogModel.items!.isNotEmpty)
                CatalogList().py16().expand()
              else
                CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
    );
  }
}










// ListView.builder(
// itemCount: CatalogModel.items!.length,
// itemBuilder: (context, index) => ItemWidget(item: CatalogModel.items![index]),
// )

//  appBar: AppBar(
// title: const Text('Catalog App'),
// )

// drawer: const MyDrawer(),

// Padding(
// padding: const EdgeInsets.all(16.0),
// child: (CatalogModel.items != null && CatalogModel.items!.isNotEmpty)
// ? GridView.builder(
// gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// mainAxisSpacing: 16,
// crossAxisSpacing: 16),
// itemBuilder: (context, index) {
// final item = CatalogModel.items![index];
// return Card(
// clipBehavior: Clip.antiAlias,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10)),
// child: GridTile(
// header: Container(
// child: Text(
// item.name.toString(),
// style:const TextStyle(
// color: Colors.white
// ),
// ),
// padding: const EdgeInsets.all(12),
// decoration: const BoxDecoration(
// color: Colors.deepPurple
// ),
// ),
// footer: Container(
// child: Text(
// item.price.toString(),
// style:const TextStyle(
// color: Colors.white
// ),
// ),
// padding: const EdgeInsets.all(12),
// decoration: const BoxDecoration(
// color: Colors.black
// ),
// ),
// child: Image.network(item.image.toString())),
// );
// },
// itemCount: CatalogModel.items!.length,
// )
// : const Center(
// child:  CircularProgressIndicator(),
// ),
// )
