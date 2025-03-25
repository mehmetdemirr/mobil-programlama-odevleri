import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 20),
            _buildProfileMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            'assets/logo.png', // Kullanıcı profil fotoğrafı
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Ahmet Yılmaz", // Kullanıcı adı
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "ahmet.yilmaz@email.com", // Kullanıcı email adresi
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 4),
            Text(
              "+90 555 123 45 67", // Kullanıcı telefon numarası
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          _buildMenuItem(
            icon: Icons.person,
            text: "Hesap Bilgileri",
            onTap: () {
              // Hesap bilgileri sayfasına yönlendirme
            },
          ),
          _buildMenuItem(
            icon: Icons.shopping_bag,
            text: "Siparişlerim",
            onTap: () {
              // Sipariş geçmişi sayfasına yönlendirme
            },
          ),
          _buildMenuItem(
            icon: Icons.settings,
            text: "Ayarlar",
            onTap: () {
              // Ayarlar sayfasına yönlendirme
            },
          ),
          _buildMenuItem(
            icon: Icons.exit_to_app,
            text: "Çıkış Yap",
            onTap: () {
              // Çıkış yapma işlevi
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.blueAccent),
            const SizedBox(width: 16),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
