import 'package:flutter/material.dart';
import 'package:project4/screens/person/model/person_model.dart';
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
        title: const Text("Müşteri Listesi"),
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
            return Center(child: Text("Veri bulunamadı !"));
          }
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: viewModel.people.length,
            itemBuilder: (context, index) {
              final person = viewModel.people[index];
              return _buildPersonCard(person);
            },
          );
        },
      ),
    );
  }

  Widget _buildPersonCard(Person person) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Ad Soyad', '${person.name} ${person.surname}'),
            _buildDivider(),
            _buildInfoRow('TC Kimlik No', _formatTC(person.tc)),
            _buildDivider(),
            Row(
              children: [
                _buildInfoItem('Yaş', '${person.age}'),
                const SizedBox(width: 20),
                _buildInfoItem('Cinsiyet', _getGenderText(person.gender)),
                const SizedBox(width: 20),
                _buildInfoItem('Medeni Hal', person.maritalStatus),
              ],
            ),
            _buildDivider(),
            _buildInfoRow('Meslek', person.profession),
            _buildDivider(),
            _buildInfoRow('İletişim', person.phone),
            _buildDivider(),
            _buildInfoRow('E-Posta', person.email),
            _buildDivider(),
            _buildInfoRow('Adres', person.address),
            _buildDivider(),
            Row(
              children: [
                _buildInfoItem('Şehir', person.city),
                const SizedBox(width: 20),
                _buildInfoItem('Ülke', person.country),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blueGrey,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(height: 1, color: Colors.grey[300]),
    );
  }

  String _getGenderText(String gender) {
    return gender == 'E' ? 'Erkek' : 'Kadın';
  }

  String _formatTC(String tc) {
    if (tc.length != 11) return tc;
    return '${tc.substring(0, 3)} ${tc.substring(3, 6)} ${tc.substring(6, 9)} ${tc.substring(9)}';
  }
}
