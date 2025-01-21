import 'package:codevidhi_firechat/features/chats/domain/entities/chats_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chats_model.freezed.dart';
part 'chats_model.g.dart';

@freezed
class ChatsModel with _$ChatsModel {
  const factory ChatsModel({
   @JsonKey(name: "chat_id") required  int  chatId,
   @Default("") @JsonKey(name: "profile_image_url") String profileImageUrl,
   @Default("") @JsonKey(name: "user_name") String userName,
   @Default("") @JsonKey(name: "last_message") String lastMessage,
   DateTime? timestamp,
   @Default(true) @JsonKey(name: "is_unread") bool isUnread,
  }) = _ChatsModel;

  factory ChatsModel.fromJson(Map<String, dynamic> json) =>
      _$ChatsModelFromJson(json);

  const ChatsModel._();

  ChatsEntity toEntity() => ChatsEntity(
        chatId: chatId,
        profileImageUrl: profileImageUrl,
        userName: userName,
        lastMessage: lastMessage,
        timestamp: timestamp ?? DateTime.now(),
        isUnread: isUnread,
      );
}
