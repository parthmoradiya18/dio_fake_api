import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dio = Dio();
  List l = [];
  List l1 = [];
  bool t = false;
  bool search =false;
  get() async {
    final response = await dio.get('https://fakestoreapi.com/products');
    print(response);
    l = response.data;
    setState(() {});
    l1=l;
    t = true;
    search=true;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:(search)?TextField(onChanged: (value) {
        l=l1.where((element) => (element.toString()).contains(value)).toList();
        setState(() {

        });
      },
        autofocus: true,cursorColor: Colors.white,): Text("Fake Api"),
        actions: [
          IconButton(onPressed: () {
            search=!search;

            setState(() {

            });
          }, icon: (search)?Icon(Icons.close):Icon(Icons.search)),
        ],
      ),
      // appBar: AppBar(
      //   title: Text("products"),
      // ),
      body: ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey,
            child: ListTile(
              title: Text("Title : ${l[index]['title']}"),
              leading: Image(
                image: NetworkImage("${l[index]['image']}"),
                height: 100,
                width: 100,
              ),
              subtitle: Text(
                  "Price : ${l[index]['price']}"
                //"\nCategory : "
                // "${l[index]['category']}\n"
                //"Rating : ${l[index]['rating']}"
              ),
            ),
          );
        },
      ),
    );
  }
}
