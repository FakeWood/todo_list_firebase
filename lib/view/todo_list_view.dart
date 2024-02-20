import 'package:flutter/material.dart';
import 'package:todo_list_firebase/view_model/tasks_view_model.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_firebase/view_model/user_view_model.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final TextEditingController _textController = TextEditingController();
  TextEditingController get textController => _textController;

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserViewModel, TasksViewModel>(
      builder: (context, uservm, tasksVM, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (context.watch<UserViewModel>().user == null)
              ElevatedButton(
                  onPressed: () =>
                      context.read<UserViewModel>().signInWithGoogle(),
                  child: const Text("Sign in"))
            else
              Column(
                children: [
                  Text(
                    "${uservm.user?.displayName.toString()}'s to do list: ",
                  ),
                  Container(
                    width: 300.0,
                    height: 200.0,
                    color: const Color.fromARGB(255, 241, 241, 241),
                    child: tasksVM.taskList != null
                        ? ListView.builder(
                            itemCount: tasksVM.taskList?.length,
                            itemBuilder: (context, index) => ListTile(
                                  title: Text(tasksVM.taskList![index]),
                                  trailing: const Icon(Icons.delete_outlined),
                                  onTap: () => tasksVM.removeTask(index),
                                ))
                        : null,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      onSubmitted: (String text) {
                        tasksVM.addTask(text);
                        textController.clear();
                      },
                      controller: _textController,
                      decoration:
                          const InputDecoration(hintText: "Enter your task"),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => context.read<UserViewModel>().signOut(),
                      child: const Text("Sign Out"))
                ],
              ),
          ],
        )),
        floatingActionButton: uservm.user != null
            ? FloatingActionButton(
                onPressed: tasksVM.clearTask,
                tooltip: "Remove ALL task",
                child: const Icon(Icons.delete_outline_outlined),
              )
            : null,
      ),
    );
  }
}
