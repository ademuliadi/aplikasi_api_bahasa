import 'package:aplikasi_api_bahasa/custom_button_navbar.dart';
import 'package:flutter/material.dart';
import 'halaman_kosa_kata.dart';


class HalamanKategori extends StatelessWidget {
  HalamanKategori({super.key});

  final List<Map<String, dynamic>> kategoriList = [
    {
      'nama': 'Kosa Kata Hewan',
      'icon': Icons.pets,
      'color': Colors.orange,
      'gradient': [Colors.orangeAccent, Colors.orange],
    },
    {
      'nama': 'Kosa Kata Buah',
      'icon': Icons.apple,
      'color': Colors.red,
      'gradient': [Colors.redAccent, Colors.red],
    },
    {
      'nama': 'Kosa Kata Bunga',
      'icon': Icons.local_florist,
      'color': Colors.pink,
      'gradient': [Colors.pinkAccent, Colors.pink],
    },
    {
      'nama': 'Kosa Kata Organ Tubuh',
      'icon': Icons.health_and_safety,
      'color': Colors.blue,
      'gradient': [Colors.lightBlueAccent, Colors.blue],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kategori Kosa Kata',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: kategoriList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final kategori = kategoriList[index];
            return GestureDetector(
              onTap: () {
                print('Navigating to: ${kategori['nama']}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HalamanKosaKata(
                      kategori: kategori['nama'],
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                shadowColor: kategori['color'].withOpacity(0.3),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: kategori['gradient'],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          kategori['icon'],
                          size: 40,
                          color: kategori['color'],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          kategori['nama'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 2,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}


