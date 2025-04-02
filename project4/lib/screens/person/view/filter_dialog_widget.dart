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

  final Map<String, List<String>> fieldOperators = {
    'name': ['contains', 'startswith', 'endswith', 'eq', 'neq'],
    'surname': ['contains', 'startswith', 'endswith', 'eq', 'neq'],
    'age': ['>', '>=', '<', '<=', '==', '!='],
    'tc': ['==', '!=', 'startswith', 'endswith'],
    'email': ['contains', 'eq', 'neq'],
    'birth_date': ['>', '>=', '<', '<=', '==', '!='],
    'gender': ['=='],
    'marital_status': ['=='],
    'profession': ['contains', 'eq', 'neq'],
    'city': ['contains', 'eq', 'neq'],
    'country': ['contains', 'eq', 'neq'],
  };

  final Map<String, String> fieldLabels = {
    'name': 'İsim',
    'surname': 'Soyadı',
    'age': 'Yaş',
    'tc': 'TC Kimlik No',
    'email': 'E-Posta',
    'birth_date': 'Doğum Tarihi',
    'gender': 'Cinsiyet',
    'marital_status': 'Medeni Hal',
    'profession': 'Meslek',
    'city': 'Şehir',
    'country': 'Ülke',
  };

  final Map<String, TextInputType> inputTypes = {
    'age': TextInputType.number,
    'tc': TextInputType.number,
    'birth_date': TextInputType.datetime,
    'email': TextInputType.emailAddress,
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
                        fieldLabels.keys.map((field) {
                          return DropdownMenuItem(
                            value: field,
                            child: Text(fieldLabels[field]!),
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
            const SizedBox(height: 10),
            _buildValueInput(),
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
                      "${fieldLabels[filter['field']]} "
                      "${_getOperatorLabel(filter['operator'])} "
                      "${filter['value']}",
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

  Widget _buildValueInput() {
    if (_selectedField == 'gender') {
      return DropdownButtonFormField<String>(
        value: _valueInput,
        items:
            const ['E', 'K']
                .map(
                  (gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender == 'E' ? 'Erkek' : 'Kadın'),
                  ),
                )
                .toList(),
        onChanged: (value) => setState(() => _valueInput = value),
        decoration: const InputDecoration(labelText: 'Değer Seç'),
      );
    }

    if (_selectedField == 'marital_status') {
      return DropdownButtonFormField<String>(
        value: _valueInput,
        items:
            const ['Bekar', 'Evli', 'Dul', 'Boşanmış']
                .map(
                  (status) =>
                      DropdownMenuItem(value: status, child: Text(status)),
                )
                .toList(),
        onChanged: (value) => setState(() => _valueInput = value),
        decoration: const InputDecoration(labelText: 'Değer Seç'),
      );
    }

    return TextFormField(
      keyboardType: inputTypes[_selectedField] ?? TextInputType.text,
      onChanged: (value) => _valueInput = value,
      decoration: InputDecoration(
        labelText:
            _selectedField != null
                ? '${fieldLabels[_selectedField!]} Değeri'
                : 'Değer',
      ),
    );
  }

  String _getOperatorLabel(String op) {
    return {
          'contains': 'içerir',
          'startswith': 'ile başlar',
          'endswith': 'ile biter',
          'eq': 'eşittir',
          'neq': 'eşit değildir',
          '>': 'büyüktür',
          '>=': 'büyük eşittir',
          '<': 'küçüktür',
          '<=': 'küçük eşittir',
          '==': 'eşittir',
          '!=': 'eşit değildir',
        }[op] ??
        op;
  }

  void _addFilter() {
    if (_selectedField == null ||
        _selectedOperator == null ||
        _valueInput == null)
      return;

    // Validasyonlar
    if (_selectedField == 'age' && int.tryParse(_valueInput!) == null) {
      _showError('Lütfen geçerli bir yaş giriniz!');
      return;
    }

    if (_selectedField == 'tc' && !_isValidTC(_valueInput!)) {
      _showError('Geçerli bir TC Kimlik No giriniz (11 haneli)!');
      return;
    }

    if (_selectedField == 'birth_date' && !_isValidDate(_valueInput!)) {
      _showError('Geçerli bir tarih formatı giriniz (YYYY-AA-GG)!');
      return;
    }

    setState(() {
      _filters.add({
        'field': _selectedField!,
        'operator': _selectedOperator!,
        'value': _getParsedValue(),
      });
      _resetSelections();
    });
  }

  dynamic _getParsedValue() {
    if (_selectedField == 'age') return int.parse(_valueInput!);
    if (_selectedField == 'tc') return _valueInput!;
    if (_selectedField == 'birth_date') return _valueInput!;
    return _valueInput!.toLowerCase();
  }

  bool _isValidTC(String value) =>
      value.length == 11 && int.tryParse(value) != null;
  bool _isValidDate(String value) => DateTime.tryParse(value) != null;

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _resetSelections() {
    _selectedField = null;
    _selectedOperator = null;
    _valueInput = null;
  }

  void _removeFilter(int index) => setState(() => _filters.removeAt(index));

  void _applyFilters(BuildContext context) {
    if (_filters.isEmpty) {
      _showError('En az bir filtre eklemelisiniz!');
      return;
    }

    final Map<String, dynamic> filters = {};
    for (var filter in _filters) {
      filters[filter['field'] as String] = {
        'operator': filter['operator'] as String,
        'value': filter['value'],
      };
    }

    context.read<PersonViewModel>().fetchPeople(filters);
    Navigator.pop(context);
  }
}
