import 'package:aplikasi_api_bahasa/custom_button_navbar.dart';
import 'package:aplikasi_api_bahasa/halaman_chat.dart';
import 'package:aplikasi_api_bahasa/halaman_kategori.dart';
import 'package:aplikasi_api_bahasa/halaman_kuis.dart';
import 'package:aplikasi_api_bahasa/halaman_latihan_soal.dart';
import 'package:flutter/material.dart';

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout berhasil')),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'LangGO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tidak ada notifikasi baru')),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings, color: Colors.white),
            onSelected: (value) {
              if (value == 'logout') {
                _logout(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: const [
                Positioned(
                  top: 16,
                  left: 16,
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      "HI Ade\nBelajar fleksibel di mana saja!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
            children: [
              buildCategoryCard(
                icon: Icons.book,
                title: "Daftar Kosa Kata",
                color: const Color.fromARGB(255, 250, 108, 132), // pastel pink
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HalamanKategori()),
                  );
                },
              ),
              buildCategoryCard(
                icon: Icons.article,
                title: "Latihan Soal",
                color: const Color.fromARGB(255, 250, 227, 124), // pastel yellow
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HalamanLatihanSoal()),
                  );
                },
              ),
              buildCategoryCard(
                icon: Icons.quiz,
                title: "Kuis",
                color: const Color.fromARGB(255, 227, 148, 236), // pastel purple
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HalamanKuis()),
                  );
                },
              ),
              buildCategoryCard(
                icon: Icons.chat,
                title: "Chat",
                color: const Color.fromARGB(255, 141, 241, 230), // pastel mint
                onTap: () { // Add this onTap
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HalamanChat()),
                  );
                },
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  static Widget buildCategoryCard({
    required IconData icon,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 36),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}