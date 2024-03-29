import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list_firebase/view_model/user_view_model.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/view_model/tasks_view_model.dart';
import 'package:provider/provider.dart';
import 'view/todo_list_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProxyProvider<UserViewModel, TasksViewModel>(
          create: (context) => TasksViewModel(context.read()),
          update: (context, userVM, previou) => TasksViewModel(userVM),
        ),
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
