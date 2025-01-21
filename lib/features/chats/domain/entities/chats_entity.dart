import 'package:equatable/equatable.dart';

class ChatsEntity extends Equatable {
  final int chatId;
  final String profileImageUrl;
  final String userName;
  final String lastMessage;
  final DateTime timestamp;
  final bool isUnread;

  const ChatsEntity({
    required this.chatId,
    required this.profileImageUrl,
    required this.userName,
    required this.lastMessage,
    required this.timestamp,
    required this.isUnread,
  });

  @override
  List<Object?> get props => [
        chatId,
        profileImageUrl,
        userName,
        lastMessage,
        timestamp,
        isUnread,
      ];
}
