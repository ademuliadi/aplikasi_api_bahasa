import 'package:flutter/material.dart';

class HalamanProfil extends StatefulWidget {
  final Map<String, dynamic>? userData;

  const HalamanProfil({Key? key, this.userData}) : super(key: key);

  @override
  State<HalamanProfil> createState() => _HalamanProfilState();
}

class _HalamanProfilState extends State<HalamanProfil> {
  late String nama;
  late String email;

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  void _initializeUserData() {
    nama = widget.userData?['nama'] ?? widget.userData?['name'] ?? 'User';
    email = widget.userData?['email'] ?? 'user@example.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  _buildProfileAvatar(),
                  const SizedBox(height: 12),
                  Text(
                    nama,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pengaturan Akun',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildMenuItem(
              icon: Icons.edit,
              title: 'Edit Nama',
              color: Colors.grey[700]!,
              onTap: _editNama,
            ),
            _buildMenuItem(
              icon: Icons.email,
              title: 'Ubah Email',
              color: Colors.grey[700]!,
              onTap: _ubahEmail,
            ),
            _buildMenuItem(
              icon: Icons.lock,
              title: 'Ubah Kata Sandi',
              color: Colors.grey[700]!,
              onTap: _ubahKataSandi,
            ),
            const SizedBox(height: 20),
            const Divider(thickness: 1),
            _buildMenuItem(
              icon: Icons.delete_forever,
              title: 'Hapus Akun',
              color: Colors.redAccent,
              onTap: _konfirmasiHapusAkun,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Colors.grey,
      child: Icon(
        Icons.person,
        size: 50,
        color: Colors.white,
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(
            color:
                color == Colors.redAccent ? Colors.redAccent : Colors.black87,
            fontWeight:
                color == Colors.redAccent ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _editNama() {
    final TextEditingController namaController =
        TextEditingController(text: nama);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Nama'),
        content: TextField(
          controller: namaController,
          decoration: const InputDecoration(
            labelText: 'Nama Baru',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                nama = namaController.text.trim();
              });
              Navigator.pop(context);
              _showSnackBar('Nama berhasil diperbarui', Colors.green);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _ubahEmail() {
    final TextEditingController emailController =
        TextEditingController(text: email);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Email'),
        content: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email Baru',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                email = emailController.text.trim();
              });
              Navigator.pop(context);
              _showSnackBar('Email berhasil diperbarui', Colors.green);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _ubahKataSandi() {
    final TextEditingController currentPass = TextEditingController();
    final TextEditingController newPass = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ubah Kata Sandi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPass,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Kata Sandi Saat Ini',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: newPass,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Kata Sandi Baru',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Kirim ke server, untuk sekarang kita tampilkan notifikasi saja
              Navigator.pop(context);
              _showSnackBar('Kata sandi berhasil diperbarui', Colors.green);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _konfirmasiHapusAkun() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Hapus Akun',
          style: TextStyle(color: Colors.redAccent),
        ),
        content: const Text(
          'Apakah Anda yakin ingin menghapus akun? Tindakan ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Akun berhasil dihapus', Colors.red);
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
