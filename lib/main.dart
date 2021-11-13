import 'package:apod/view_models/date_view_model.dart';
import 'package:apod/view_models/image_view_model.dart';
import 'package:flutter/material.dart';
import 'package:apod/View/first_screen.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => DateViewModel()),
          ChangeNotifierProvider(create: (_) => ImageViewModel())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FirstScreen(),
        )
    );
  }
}
