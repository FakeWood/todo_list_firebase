import 'package:flutter/material.dart';
import 'package:my_first_flutter/view_model/todo_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController _textController = TextEditingController();
  TextEditingController get textController => _textController;

  @override
  Widget build(BuildContext context) {
    const uuid = Uuid();
    return Consumer<MyViewModel>(
      builder: (context, myViewModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "To do list: ",
            ),
            Container(
              width: 300.0,
              height: 200.0,
              color: const Color.fromARGB(255, 241, 241, 241),
              child: ListView.builder(
                  itemCount: myViewModel.tasks.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(myViewModel.tasks[index].title),
                        trailing: const Icon(Icons.delete_outlined),
                        onTap: () =>
                            myViewModel.removeTask(myViewModel.tasks[index].id),
                      )),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                onSubmitted: (String text) {
                  myViewModel.addTask(uuid.v4(), text);
                  textController.clear();
                },
                controller: _textController,
                decoration: const InputDecoration(hintText: "Enter your task"),
              ),
            )
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: myViewModel.clearTask,
          tooltip: "Remove ALL task",
          child: const Icon(Icons.delete_outline_outlined),
        ),
      ),
    );
  }
}
