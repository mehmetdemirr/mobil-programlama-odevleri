import 'package:flutter/material.dart';
import '../models/customer_model.dart';
import './add_customer_screen.dart';
import './edit_customer_screen.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Tümü';
  final List<String> _filterOptions = ['Tümü', 'Aktif', 'Pasif'];

  // Örnek veri
  final List<Customer> _customers = [
    Customer(
      id: '1',
      name: 'Ahmet Yılmaz',
      email: 'ahmet@firma.com',
      phone: '5551234567',
      company: 'Firma A',
      status: 'Aktif',
      createdAt: DateTime.now(),
    ),
    Customer(
      id: '2',
      name: 'Ayşe Demir',
      email: 'ayse@sirket.com',
      phone: '5559876543',
      company: 'Şirket B',
      status: 'Aktif',
      createdAt: DateTime.now(),
    ),
    Customer(
      id: '3',
      name: 'Mehmet Kaya',
      email: 'mehmet@holding.com',
      phone: '5554567890',
      company: 'Holding C',
      status: 'Pasif',
      createdAt: DateTime.now(),
    ),
    Customer(
      id: '4',
      name: 'Zeynep Şahin',
      email: 'zeynep@limited.com',
      phone: '5553456789',
      company: 'Limited D',
      status: 'Aktif',
      createdAt: DateTime.now(),
    ),
    Customer(
      id: '5',
      name: 'Ali Öztürk',
      email: 'ali@anonim.com',
      phone: '5552345678',
      company: 'Anonim E',
      status: 'Pasif',
      createdAt: DateTime.now(),
    ),
  ];

  List<Customer> get _filteredCustomers {
    return _customers.where((customer) {
      final matchesSearch = customer.name.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ) ||
          customer.email.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              );
      final matchesFilter =
          _selectedFilter == 'Tümü' || customer.status == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteriler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddCustomerDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Müşteri Ara...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedFilter,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: _filterOptions
                        .map((filter) => DropdownMenuItem(
                              value: filter,
                              child: Text(filter),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedFilter = value);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: MediaQuery.of(context).size.width >= 600
                  ? GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 1200 ? 3 : 2,
                        childAspectRatio:
                            MediaQuery.of(context).size.width / (2 * 250),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _filteredCustomers.length,
                      itemBuilder: (context, index) => SizedBox(
                          height: 250,
                          child: _buildCustomerCard(_filteredCustomers[index])),
                    )
                  : ListView.builder(
                      itemCount: _filteredCustomers.length,
                      itemBuilder: (context, index) =>
                          _buildCustomerListItem(_filteredCustomers[index]),
                    )),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(Customer customer) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    customer.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () =>
                          _showEditCustomerDialog(context, customer),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          _showDeleteConfirmation(context, customer),
                    ),
                  ],
                ),
                _buildStatusChip(customer.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(customer.company),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email, size: 16),
                const SizedBox(width: 8),
                Text(customer.email),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(width: 8),
                Text(customer.phone),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerListItem(Customer customer) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          customer.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${customer.company}\n${customer.email}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatusChip(customer.status),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditCustomerDialog(context, customer),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _showDeleteConfirmation(context, customer),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final color = status == 'Aktif' ? Colors.green : Colors.grey;
    return Chip(
      label: Text(
        status,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    );
  }

  Future<void> _showAddCustomerDialog(BuildContext context) async {
    final result = await Navigator.push<Customer>(
      context,
      MaterialPageRoute(builder: (context) => const AddCustomerScreen()),
    );

    if (result != null) {
      setState(() => _customers.add(result));
    }
  }

  Future<void> _showEditCustomerDialog(
      BuildContext context, Customer customer) async {
    final result = await Navigator.push<Customer>(
      context,
      MaterialPageRoute(
        builder: (context) => EditCustomerScreen(customer: customer),
      ),
    );

    if (result != null) {
      setState(() {
        final index = _customers.indexWhere((c) => c.id == result.id);
        if (index != -1) {
          _customers[index] = result;
        }
      });
    }
  }

  Future<void> _showDeleteConfirmation(
      BuildContext context, Customer customer) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Müşteriyi Sil'),
        content: Text(
            '${customer.name} müşterisini silmek istediğinize emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _customers.remove(customer));
              Navigator.pop(context);
            },
            child: const Text(
              'Sil',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
