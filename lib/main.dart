import 'package:flutter/material.dart';
import 'package:image_finder/repository/image_repository.dart';
import 'package:image_finder/ui/home_page.dart';
import 'package:image_finder/ui/search_result.dart';
import 'package:provider/provider.dart';
import 'package:image_finder/providers/image_provider.dart' as ip;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ip.ImageProvider>(
      create: (_) => ip.ImageProvider(ImageRepository()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}

