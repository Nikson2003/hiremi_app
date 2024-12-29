import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'selected_index_provider.dart';
import 'open_animation.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SelectedIndexProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hiremi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: OpenAnimation(),
    );
  }
}
