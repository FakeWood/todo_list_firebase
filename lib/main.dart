import 'package:flutter/material.dart';
import 'package:my_first_flutter/view_model/todo_list_view_model.dart';
import 'package:provider/provider.dart';
import 'view/todo_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 230, 211, 89)),
          useMaterial3: true,
        ),
        home: MyHomePage(title: 'To do list'), //Which widget to be homepage
      ),
    );
  }
}
