import 'package:flutter/material.dart';
import 'ui/screens/main_screen.dart';
import 'viewModel/location_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocationViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'AvenirNextLTPro',
        ),
        home: const MainScreen(),
      ),
    );
  }
}
