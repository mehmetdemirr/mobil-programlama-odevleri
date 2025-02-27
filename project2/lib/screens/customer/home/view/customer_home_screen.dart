import 'package:flutter/material.dart';
import 'package:project2/screens/splash/view/splash_screen.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Müşteri Paneli',
          style:
              TextStyle(color: Color(0xFF1565C0), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: Color(0xFF1565C0)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined, color: Color(0xFF1565C0)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SplashScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hoş Geldiniz',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Projelerinizi buradan takip edebilirsiniz',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.assignment_outlined,
                          color: Color(0xFF1565C0), size: 40),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aktif Projeler',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '3 proje devam ediyor',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildMenuCard(
                    icon: Icons.assignment_outlined,
                    title: 'Aktif Projelerim',
                    subtitle: 'Devam eden projelerinizi görüntüleyin',
                    color: const Color(0xFF1565C0),
                  ),
                  const SizedBox(height: 15),
                  _buildMenuCard(
                    icon: Icons.history_outlined,
                    title: 'Proje Geçmişi',
                    subtitle: 'Tamamlanan projelerinizi inceleyin',
                    color: const Color(0xFF4CAF50),
                  ),
                  const SizedBox(height: 15),
                  _buildMenuCard(
                    icon: Icons.message_outlined,
                    title: 'Mesajlar',
                    subtitle: 'İletişim kutunuzu kontrol edin',
                    color: const Color(0xFFFFA726),
                  ),
                  const SizedBox(height: 15),
                  _buildMenuCard(
                    icon: Icons.person_outline,
                    title: 'Profil',
                    subtitle: 'Hesap bilgilerinizi yönetin',
                    color: const Color(0xFF7E57C2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }
}
