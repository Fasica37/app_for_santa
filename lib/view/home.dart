import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/child_list_bloc.dart';
import '../bloc/child_list_event.dart';
import '../bloc/child_list_state.dart';
import '../models/child.dart';

class MyHomePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController behaviorController = TextEditingController();

  void _showAddChildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Child'),
          content: IntrinsicHeight(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: countryController,
                  decoration: const InputDecoration(labelText: 'Country'),
                ),
                TextField(
                  controller: behaviorController,
                  decoration: const InputDecoration(labelText: 'Behavior'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String name = nameController.text;
                String country = countryController.text;
                if (name.isNotEmpty && country.isNotEmpty) {
                  context.read<ChildListBloc>().add(
                        AddChildEvent(
                          Child(
                            name: name,
                            country: country,
                            isNice: behaviorController.text == 'nice'
                                ? true
                                : false,
                          ),
                        ),
                      );
                  nameController.clear();
                  countryController.clear();
                  behaviorController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        foregroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Santa\'s List',
          ),
        ),
      ),
      body: BlocBuilder<ChildListBloc, ChildListState>(
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedState) {
            return ListView.builder(
              itemCount: state.children.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.children[index].name),
                  subtitle: Text(state.children[index].country),
                  trailing: state.children[index].isNice
                      ? const Text(
                          'nice',
                          style: TextStyle(color: Colors.green),
                        )
                      : const Text(
                          'naughty',
                          style: TextStyle(color: Colors.red),
                        ),
                  onTap: () {
                    context.read<ChildListBloc>().add(ChangeStatusEvent(index));
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddChildDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
