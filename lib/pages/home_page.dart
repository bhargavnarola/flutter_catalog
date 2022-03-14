import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/catalog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_catalog/widgets/themes.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import 'dart:async';

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
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatelogHeader(),
              if (CatalogModel.items != null && CatalogModel.items!.isNotEmpty)
                CatalogList().expand()
              else
                Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class CatalogList extends StatelessWidget {
  const CatalogList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: false,
        itemCount: CatalogModel.items!.length,
        itemBuilder: (context, index) {
          final catalog = CatalogModel.items![index];
          return CatalogItem(catalog: catalog);
        });
  }
}

class CatalogItem extends StatelessWidget {
  final Item? catalog;

  const CatalogItem({Key? key, @required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        CatalogImage(image: catalog!.image.toString()),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              catalog!.name.toString().text.lg.color(MyTheme.darkBluishColor).bold.make(),
              catalog!.desc.toString().text.textStyle(context.captionStyle!).make(),
              10.heightBox,
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                buttonPadding: EdgeInsets.zero,
                children: [
                  "\$${catalog!.price.toString()}".text.bold.xl.make(),
                  ElevatedButton(
                    onPressed: () {},
                    child: "Buy".text.make(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(MyTheme.darkBluishColor),
                      shape: MaterialStateProperty.all(
                        StadiumBorder()
                      )
                    ),

                  )
                ],
              ).pOnly(right: 8.0)
            ],
          ),
        )
      ],
    )).white.roundedLg.square(150).make().py16();
  }
}

class CatelogHeader extends StatelessWidget {
  const CatelogHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog App".text.xl5.bold.color(MyTheme.darkBluishColor).make(),
        "Trending products".text.xl2.make()
      ],
    );
  }
}

class CatalogImage extends StatelessWidget {
  
  final String? image;
  const CatalogImage({Key? key,@required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(image!)
        .box
        .rounded
        .p8
        .color(MyTheme.creamColor)
        .make().p16().w40(context);
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
