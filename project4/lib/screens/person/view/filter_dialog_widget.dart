import 'package:flutter/material.dart';
import 'package:project4/screens/person/viewmodel/person_viewmodel.dart';
import 'package:provider/provider.dart';

class PersonFilterDialog extends StatefulWidget {
  const PersonFilterDialog({super.key});

  @override
  _PersonFilterDialogState createState() => _PersonFilterDialogState();
}

class _PersonFilterDialogState extends State<PersonFilterDialog> {
  String? _selectedField;
  String? _selectedOperator;
  String? _valueInput;
  final List<Map<String, dynamic>> _filters = [];

  Map<String, List<String>> fieldOperators = {
    'name': ['contains', 'startswith', 'endswith', 'eq'],
    'age': ['>', '>=', '<', '<=', '=='],
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filtrele'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Yeni Filtre Ekleme Alanı
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedField,
                    items:
                        ['name', 'age'].map((field) {
                          return DropdownMenuItem(
                            value: field,
                            child: Text(field == 'name' ? 'İsim' : 'Yaş'),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedField = value;
                        _selectedOperator = null;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Alan Seç'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedOperator,
                    items:
                        ((_selectedField != null
                                    ? fieldOperators[_selectedField!]
                                    : null) ??
                                <String>[])
                            .map<DropdownMenuItem<String>>(
                              (String op) =>
                                  DropdownMenuItem(value: op, child: Text(op)),
                            )
                            .toList(),
                    onChanged:
                        (String? value) =>
                            setState(() => _selectedOperator = value),
                    decoration: const InputDecoration(labelText: 'Operatör'),
                  ),
                ),
              ],
            ),
            TextFormField(
              keyboardType:
                  _selectedField == 'age'
                      ? TextInputType.number
                      : TextInputType.text,
              onChanged: (value) => _valueInput = value,
              decoration: InputDecoration(
                labelText:
                    _selectedField == 'age' ? 'Yaş Değeri' : 'İsim Değeri',
              ),
            ),
            ElevatedButton(
              onPressed: _addFilter,
              child: const Text('Filtre Ekle'),
            ),
            const Divider(),
            // Eklenen Filtreler
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filters.length,
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  return ListTile(
                    title: Text(
                      "${filter['field']} ${filter['operator']} ${filter['value']}",
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeFilter(index),
                    ),
                  );
                },
              ),
            ),
            // İşlem Butonları
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('İptal'),
                ),
                ElevatedButton(
                  onPressed: () => _applyFilters(context),
                  child: const Text('Uygula'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addFilter() {
    if (_selectedField == null ||
        _selectedOperator == null ||
        _valueInput == null)
      return;

    if (_selectedField == 'age' && int.tryParse(_valueInput!) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen geçerli bir yaş giriniz!')),
      );
      return;
    }

    setState(() {
      _filters.add({
        'field': _selectedField!,
        'operator': _selectedOperator!,
        'value':
            _selectedField == 'age' ? int.parse(_valueInput!) : _valueInput!,
      });
      _selectedField = null;
      _selectedOperator = null;
      _valueInput = null;
    });
  }

  void _removeFilter(int index) {
    setState(() {
      _filters.removeAt(index);
    });
  }

  void _applyFilters(BuildContext context) {
    if (_filters.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('En az bir filtre eklemelisiniz!')),
      );
      return;
    }

    final Map<String, dynamic> filters = {};
    for (var filter in _filters) {
      filters[filter['field']] = {
        'operator': filter['operator'],
        'value': filter['value'],
      };
    }

    context.read<PersonViewModel>().fetchPeople(filters);
    Navigator.pop(context);
  }
}
