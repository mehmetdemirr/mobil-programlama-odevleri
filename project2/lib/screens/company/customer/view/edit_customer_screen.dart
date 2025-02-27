import 'package:flutter/material.dart';
import '../models/customer_model.dart';

class EditCustomerScreen extends StatefulWidget {
  final Customer customer;

  const EditCustomerScreen({super.key, required this.customer});

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _companyController;
  late String _status;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer.name);
    _emailController = TextEditingController(text: widget.customer.email);
    _phoneController = TextEditingController(text: widget.customer.phone);
    _companyController = TextEditingController(text: widget.customer.company);
    _status = widget.customer.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteri Düzenle'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1565C0),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Ad Soyad',
                icon: Icons.person_outline,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Ad Soyad gerekli' : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _emailController,
                label: 'E-posta',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'E-posta gerekli' : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _phoneController,
                label: 'Telefon',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Telefon gerekli' : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _companyController,
                label: 'Firma Adı',
                icon: Icons.business_outlined,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Firma adı gerekli' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(
                  labelText: 'Durum',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.info_outline),
                ),
                items: const [
                  DropdownMenuItem(value: 'Aktif', child: Text('Aktif')),
                  DropdownMenuItem(value: 'Pasif', child: Text('Pasif')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _status = value);
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _updateCustomer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Değişiklikleri Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(icon),
      ),
      validator: validator,
    );
  }

  void _updateCustomer() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedCustomer = Customer(
        id: widget.customer.id,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        company: _companyController.text,
        status: _status,
        createdAt: widget.customer.createdAt,
      );
      Navigator.pop(context, updatedCustomer);
    }
  }
}
