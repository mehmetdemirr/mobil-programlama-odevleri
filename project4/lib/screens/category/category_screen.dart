import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final List<Map<String, String>> categories = [
    {'name': 'Elektronik', 'icon': 'assets/logo.png'},
    {'name': 'Moda', 'icon': 'assets/logo.png'},
    {'name': 'Ev & Yaşam', 'icon': 'assets/logo.png'},
    {'name': 'Gıda', 'icon': 'assets/logo.png'},
    {'name': 'Kitaplar', 'icon': 'assets/logo.png'},
    {'name': 'Güzellik', 'icon': 'assets/logo.png'},
    {'name': 'Spor', 'icon': 'assets/logo.png'},
    {'name': 'Oyun', 'icon': 'assets/logo.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategoriler'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Arama işlevi buraya eklenebilir
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryItem(category);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, String> category) {
    return InkWell(
      onTap: () {
        // Kategoriye tıklandığında yapılacak işlem
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                category['icon']!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              category['name']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
