import 'package:flutter/material.dart';
import 'package:project2/screens/splash_screen.dart';

class CompanyHomeScreen extends StatelessWidget {
  const CompanyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Şirket Paneli',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Hoş Geldiniz',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: const [
                DashboardCard(
                  icon: Icons.assignment_outlined,
                  title: 'Projeler',
                  color: Color(0xFF1565C0),
                  subtitle: '12 Aktif Proje',
                ),
                DashboardCard(
                  icon: Icons.people_outline,
                  title: 'Müşteriler',
                  color: Color(0xFF4CAF50),
                  subtitle: '48 Müşteri',
                ),
                DashboardCard(
                  icon: Icons.bar_chart_outlined,
                  title: 'Raporlar',
                  color: Color(0xFFFFA726),
                  subtitle: 'Aylık Rapor',
                ),
                DashboardCard(
                  icon: Icons.settings_outlined,
                  title: 'Ayarlar',
                  color: Color(0xFF7E57C2),
                  subtitle: 'Sistem Ayarları',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final String subtitle;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
