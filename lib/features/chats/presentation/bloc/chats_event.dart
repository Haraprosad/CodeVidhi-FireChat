import 'package:equatable/equatable.dart';

sealed class ChatsEvent extends Equatable {
  const ChatsEvent();

  @override
  List<Object> get props => [];
}

final class ChatsFetched extends ChatsEvent {}
final class ChatsLoadMore extends ChatsEvent {}
