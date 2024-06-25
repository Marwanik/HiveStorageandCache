import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:listwithcasheandstorage/model/cat_model.dart';
import 'package:listwithcasheandstorage/service/cat_service.dart';

class catsScreen extends StatefulWidget {
  @override
  _catsScreenState createState() => _catsScreenState();
}

class _catsScreenState extends State<catsScreen> {
  final Box<CatModel> catsBox = Hive.box<CatModel>('cats');
  List<CatModel> catsList = [];
  int displayCount = 5;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      List<CatModel> cats = await apiService.fetchcats();


      if (cats.isEmpty) {
        throw Exception('Empty response from API');
      }

      print('Fetched cats: $cats');
      await catsBox.clear();
      await catsBox.addAll(cats);
      setState(() {
        catsList = cats;
      });
    } catch (e) {
      print('Error fetching cats from API: $e');
      print('Fetching data from Hive');
      setState(() {
        catsList = catsBox.values.toList();
      });
    }
    print('cats list after fetch: $catsList');
  }


  void loadMore() {
    setState(() {
      displayCount += 5;
    });
    print('Display count after load more: $displayCount');
  }

  void clearData() {
    setState(() {
      catsList = [];
      catsBox.clear();
    });
    print('cats list after clear: $catsList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cats'),
      ),
      body: catsList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: catsList.length > displayCount ? displayCount : catsList.length,
        itemBuilder: (context, index) {
          final cats = catsList[index];
          return ListTile(
            leading: Image.network( cats.image),
            title: Text(cats.name),
            subtitle: Text('cats.origin')
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: loadMore,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: clearData,
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}