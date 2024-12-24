import 'package:flutter/material.dart';
import 'main_layout.dart';
import 'package:provider/provider.dart';
import 'selected_index_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          SelectedIndexProvider(), // Provide the state globally
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
      home: MainLayout(),
    );
  }
}
