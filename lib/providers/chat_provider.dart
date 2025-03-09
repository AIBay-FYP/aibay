import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_model.dart';

final chatProvider = StateProvider<List<ChatModel>>((ref) {
  return List.generate(
    5,
    (index) => ChatModel(
      name: "John Doe",
      message: "Hi, may I know the final price of this product?",
      time: "19:23",
      profileImage: "assets/profile.jpg",
    ),
  );
});
