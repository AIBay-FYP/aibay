// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../models/chat_model.dart';
// import '../providers/chat_provider.dart';

// class ChatTile extends ConsumerStatefulWidget {
//   final ChatModel chat;
//   final bool isSelected;

//   const ChatTile({super.key, required this.chat, required this.isSelected});

//   @override
//   _ChatTileState createState() => _ChatTileState();
// }

// class _ChatTileState extends ConsumerState<ChatTile> {
//   bool isHovered = false; // Track hover state

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final bool isActive = widget.isSelected || isHovered; // Selected or hovered

//     return MouseRegion(
//       onEnter: (_) => setState(() => isHovered = true), // Detect hover start
//       onExit: (_) => setState(() => isHovered = false), // Detect hover end
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: isActive ? theme.colorScheme.primary : theme.colorScheme.surface,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(widget.chat.profileImage),
//               radius: 24,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.chat.name,
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: theme.colorScheme.onSurface,
//                     ),
//                   ),
//                   Text(
//                     widget.chat.message,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: theme.colorScheme.onSurface.withOpacity(0.7),
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               widget.chat.time,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: theme.colorScheme.onSurface.withOpacity(0.5),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_model.dart';
import '../screens/chatdetail.dart'; // Import the chat detail screen

class ChatTile extends ConsumerStatefulWidget {
  final ChatModel chat;
  
  const ChatTile({super.key, required this.chat});

  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends ConsumerState<ChatTile> {
  bool isHovered = false; // Track hover state

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isActive = isHovered; // Selected or hovered

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(chatTitle: widget.chat.name),
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true), // Detect hover start
        onExit: (_) => setState(() => isHovered = false), // Detect hover end
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isActive ? theme.colorScheme.primary : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.chat.profileImage),
                radius: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chat.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      widget.chat.message,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                widget.chat.time,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
