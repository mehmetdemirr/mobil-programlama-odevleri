import 'package:flutter/material.dart';
import 'package:project4/screens/person/view/filter_dialog_widget.dart';
import 'package:project4/screens/person/viewmodel/person_viewmodel.dart';
import 'package:provider/provider.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});
  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PersonViewModel>().fetchPeople();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Müşterilerim"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed:
                () => showDialog(
                  context: context,
                  builder: (context) => const PersonFilterDialog(),
                ),
          ),
        ],
      ),
      body: Consumer<PersonViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.people.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: viewModel.people.length,
            itemBuilder: (context, index) {
              final person = viewModel.people[index];
              return ListTile(
                title: Text(person.name),
                subtitle: Text('Yaş: ${person.age}'),
              );
            },
          );
        },
      ),
    );
  }
}
