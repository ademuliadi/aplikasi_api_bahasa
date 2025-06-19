import 'package:aplikasi_api_bahasa/custom_button_navbar.dart';
import 'package:flutter/material.dart';

// Definisi kelas ChatMessage
class ChatMessage {
  final String text;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.timestamp});
}

class HalamanChat extends StatefulWidget {
  const HalamanChat({Key? key}) : super(key: key);

  @override
  State<HalamanChat> createState() => _HalamanChatState();
}

class _HalamanChatState extends State<HalamanChat> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = []; // Mengubah tipe list

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: _messageController.text,
            timestamp: DateTime.now(), // Menambahkan timestamp saat ini
          ),
        );
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index]; // Ambil objek ChatMessage
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end, // Agar waktu ada di bawah pesan
                      children: [
                        Text(message.text), // Teks pesan
                        const SizedBox(height: 4),
                        Text(
                          _formatTimestamp(message.timestamp), // Waktu pengiriman
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8.0),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  mini: true,
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  // Helper function untuk memformat timestamp
  String _formatTimestamp(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute'; // Contoh format HH:MM
  }
}