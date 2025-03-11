import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatTitle;

  const ChatDetailScreen({super.key, required this.chatTitle});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text.trim());
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final backgroundColor = theme.colorScheme.surface;
    final myMessageBubbleColor = theme.colorScheme.primary; // Sender message color
    final inputFieldColor = theme.colorScheme.onSecondary; // TextField color

    double screenWidth = MediaQuery.of(context).size.width;
    double bubbleWidth = screenWidth * 0.75; // Max width for message bubbles

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            // User Profile Picture
            CircleAvatar(
              backgroundColor: theme.colorScheme.secondary, // Placeholder Color
              backgroundImage: NetworkImage(
                "https://via.placeholder.com/150", // Replace with user profile URL
              ),
            ),
            const SizedBox(width: 10), // Space between image and title
            Text(
              widget.chatTitle,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.description, color: textColor), // Contract Icon
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Contract icon tapped!")),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight, // Align all messages to the right
                  child: Container(
                    constraints: BoxConstraints(maxWidth: bubbleWidth),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: myMessageBubbleColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _messages[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type message...",
                      hintStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
                      filled: true,
                      fillColor: inputFieldColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.send, color: theme.colorScheme.onSurface),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
