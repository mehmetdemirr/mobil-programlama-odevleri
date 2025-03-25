import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("İstatistikler")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Genel Verilerimiz",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Genel İstatistik Kartları
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatCard(
                  "Toplam Ürün",
                  "120",
                  Icons.shopping_cart,
                  Colors.blue,
                ),
                _buildStatCard(
                  "Kategoriler",
                  "10",
                  Icons.category,
                  Colors.orange,
                ),
                _buildStatCard(
                  "Satış Oranı",
                  "%85",
                  Icons.trending_up,
                  Colors.green,
                ),
              ],
            ),
            SizedBox(height: 20),

            // Satış Bar Grafiği
            SizedBox(
              height: 180,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yıllık Satış Grafiği",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: BarChart(
                          BarChartData(
                            barGroups: [
                              BarChartGroupData(
                                x: 1,
                                barRods: [
                                  BarChartRodData(
                                    toY: 2,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 2,
                                barRods: [
                                  BarChartRodData(
                                    toY: 7,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 3,
                                barRods: [
                                  BarChartRodData(
                                    toY: 4,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 4,
                                barRods: [
                                  BarChartRodData(
                                    toY: 13,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 5,
                                barRods: [
                                  BarChartRodData(
                                    toY: 0,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 6,
                                barRods: [
                                  BarChartRodData(
                                    toY: 0,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 7,
                                barRods: [
                                  BarChartRodData(
                                    toY: 0,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 8,
                                barRods: [
                                  BarChartRodData(
                                    toY: 0,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 9,
                                barRods: [
                                  BarChartRodData(
                                    toY: 0,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 10,
                                barRods: [
                                  BarChartRodData(
                                    toY: 0,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 11,
                                barRods: [
                                  BarChartRodData(
                                    toY: 0,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              BarChartGroupData(
                                x: 12,
                                barRods: [
                                  BarChartRodData(
                                    toY: 0,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ],
                            titlesData: FlTitlesData(show: true),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Pasta Grafiği
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kategori Dağılımı",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                value: 40,
                                color: Colors.blue,
                                title: "Elektronik",
                              ),
                              PieChartSectionData(
                                value: 30,
                                color: Colors.orange,
                                title: "Giyim",
                              ),
                              PieChartSectionData(
                                value: 20,
                                color: Colors.green,
                                title: "Ev & Yaşam",
                              ),
                              PieChartSectionData(
                                value: 10,
                                color: Colors.red,
                                title: "Diğer",
                              ),
                            ],
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // İstatistik Kartlarını Oluşturma
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 30, color: color),
              SizedBox(height: 10),
              Text(
                value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
