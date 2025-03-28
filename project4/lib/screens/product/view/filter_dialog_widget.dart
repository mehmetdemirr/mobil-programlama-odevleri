import 'package:flutter/material.dart';
import 'package:project4/screens/product/viewmodel/product_view_model.dart';
import 'package:project4/widgets/custom_dropdown_widget.dart';
import 'package:provider/provider.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? _selectedSortBy;
  String? _selectedOrder;
  String? _selectedOperator = "=";

  // Sıralama kriterleri
  final List<String> sortFields = ['title', 'price', 'rating', 'stock'];

  // Operator'ler için değerler
  List<String> operators = ['='];

  // Sıralama yönleri
  final List<String> orderTypes = ['asc', 'desc'];
  final Map<String, String> orderLabels = {
    'asc': 'Artan Sırala (A-Z)',
    'desc': 'Azalan Sırala (Z-A)',
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Sırala',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sıralama Kriteri Seçimi
          CustomhDropDownWidget<String>(
            items: sortFields,
            selectedValue: _selectedSortBy,
            hint: "Sıralama Kriteri Seç",
            // itemBuilder: (value) => sortFieldLabels[value] ?? value,
            onChanged: (value) {
              setState(() {
                _selectedSortBy = value;
              });
            },
            isSearch: false,
          ),
          const SizedBox(height: 16),
          // Operator Dropdown
          CustomhDropDownWidget<String>(
            items: operators,
            selectedValue: _selectedOperator,
            hint: "Operatör Seç",
            onChanged: (value) {
              setState(() {
                _selectedOperator = value;
              });
            },
            isSearch: false,
          ),
          const SizedBox(height: 16),

          // Sıralama Yönü Seçimi
          CustomhDropDownWidget<String>(
            items: orderTypes,
            selectedValue: _selectedOrder,
            hint: "Sıralama Yönü Seç",
            // itemBuilder: (value) => orderLabels[value] ?? value,
            onChanged: (value) {
              setState(() {
                _selectedOrder = value;
              });
            },
            isSearch: false,
          ),
          const SizedBox(height: 20),

          // Uygula Butonu
          ElevatedButton(
            onPressed: () {
              if (_selectedSortBy != null && _selectedOrder != null) {
                context.read<ProductProvider>().sortProducts(
                  _selectedSortBy!,
                  _selectedOrder!,
                );
                Navigator.pop(context, {
                  'sortBy': _selectedSortBy,
                  'order': _selectedOrder,
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Lütfen tüm sıralama ayarlarını seçin."),
                  ),
                );
              }
            },
            child: const Text("Uygula"),
          ),
        ],
      ),
    );
  }
}
