import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Model pesan
class ChatMessage {
  final String text;
  final DateTime timestamp;
  final bool isMe;

  ChatMessage({
    required this.text,
    required this.timestamp,
    required this.isMe,
  });
}

class HalamanChat extends StatefulWidget {
  const HalamanChat({Key? key}) : super(key: key);

  @override
  State<HalamanChat> createState() => _HalamanChatState();
}

class _HalamanChatState extends State<HalamanChat> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  // Ganti IP sesuai dengan IP backend WebSocket kamu
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.1.16:4001'), // Ganti IP sesuai kebutuhan
  );

  @override
  void initState() {
    super.initState();
    // Terima pesan dari server
    _channel.stream.listen((data) {
      setState(() {
        _messages.add(ChatMessage(
          text: data.toString(),
          timestamp: DateTime.now(),
          isMe: false,
        ));
      });

      _scrollToBottom();
    });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      final text = _messageController.text;

      setState(() {
        _messages.add(ChatMessage(
          text: text,
          timestamp: DateTime.now(),
          isMe: true,
        ));
      });

      _channel.sink.add(text); // Kirim ke server
      _messageController.clear();

      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return Align(
                  alignment: message.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: message.isMe ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(message.text),
                        const SizedBox(height: 4),
                        Text(
                          _formatTimestamp(message.timestamp),
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
