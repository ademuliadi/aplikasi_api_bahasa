import 'package:aplikasi_api_bahasa/halaman_login.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HalamanRegister extends StatefulWidget {
  const HalamanRegister({super.key});

  @override
  State<HalamanRegister> createState() => _HalamanRegisterState();
}

class _HalamanRegisterState extends State<HalamanRegister> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String registerMutation = r'''
    mutation Register($username: String!, $email: String!, $password: String!) {
      register(username: $username, email: $email, password: $password)
    }
  ''';

  void _showSnackbar(String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color ?? Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.teal),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Mutation(
              options: MutationOptions(
                document: gql(registerMutation),
                onCompleted: (_) {
                  _showSnackbar("Registrasi berhasil!", color: Colors.green);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HalamanLogin()),
                  );
                },
                onError: (error) {
                  _showSnackbar("Registrasi gagal: ${error?.graphqlErrors.first.message ?? 'Unknown error'}");
                },
              ),
              builder: (RunMutation runMutation, QueryResult? result) {
                return Column(
                  children: [
                    _buildTextField(
                      controller: _usernameController,
                      icon: Icons.person,
                      hint: 'Username',
                      isPassword: false,
                      border: inputBorder,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _emailController,
                      icon: Icons.email,
                      hint: 'Email Address',
                      isPassword: false,
                      border: inputBorder,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _passwordController,
                      icon: Icons.lock,
                      hint: 'Password',
                      isPassword: true,
                      border: inputBorder,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final username = _usernameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        if (username.isEmpty || email.isEmpty || password.isEmpty) {
                          _showSnackbar("Semua field harus diisi");
                          return;
                        }

                        runMutation({
                          'username': username,
                          'email': email,
                          'password': password,
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: result?.isLoading ?? false
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Sign Up', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HalamanLogin()),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: 'Have an account? ',
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ],
                        ),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    required bool isPassword,
    required InputBorder border,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hint,
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
    );
  }
}
