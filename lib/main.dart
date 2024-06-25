import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:listwithcasheandstorage/config/get_it_config.dart';
import 'package:listwithcasheandstorage/controller/counter_controller.dart';
import 'package:listwithcasheandstorage/homeScreen.dart';
import 'package:listwithcasheandstorage/model/cat_model.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CatModelAdapter());
  await Hive.openBox<CatModel>('cats');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: catsScreen(),
      ),
    );
  }
}