// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../providers/chat_provider.dart';
// import '../widgets/chat_tile.dart';
// import '../widgets/search_bar.dart';

// class ChatScreen extends ConsumerWidget {
//   const ChatScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final chats = ref.watch(chatProvider);

//     return Scaffold(
//       backgroundColor: Colors.grey[900],
//       appBar: AppBar(
//         title: const Text("Chats"),
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           const SearchBarWidget(),
//           Expanded(
//             child: ListView.builder(
//               itemCount: chats.length,
//               itemBuilder: (context, index) {
//                 return ChatTile(chat: chats[index], isSelected: index == 0);
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.black,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_tile.dart';
import '../widgets/search_bar.dart';
import '../theme/app_colors.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatProvider);
    final int newMessagesCount = chats.length; // Assuming all messages are new
    final theme = Theme.of(context); // Get the current theme

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Center(child: const Text("Chats")),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SearchBarWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row( // Wrap "Messages" and the number together
                  children: [
                    Text(
                      "Messages",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    if (newMessagesCount > 0)
                      Container(
                        margin: const EdgeInsets.only(left: 6), // Adjust spacing if needed
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          newMessagesCount.toString(),
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return ChatTile(chat: chats[index], isSelected: index == 0);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.colorScheme.surface,
        selectedItemColor: theme.colorScheme.onSurface,
        unselectedItemColor: theme.colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
      ),
    );
  }
}
