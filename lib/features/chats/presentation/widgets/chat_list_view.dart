import 'package:codevidhi_firechat/core/utils/app_spacing.dart';
import 'package:codevidhi_firechat/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:codevidhi_firechat/features/chats/presentation/bloc/chats_event.dart';
import 'package:codevidhi_firechat/features/chats/presentation/bloc/chats_state.dart';
import 'package:codevidhi_firechat/features/chats/presentation/widgets/chat_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codevidhi_firechat/core/widgets/pagination_loader.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ChatsBloc>().add(ChatsLoadMore());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatsBloc, ChatsState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.smallW),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: state.chats.length + (state.hasReachedMax ? 0 : 1),
            itemBuilder: (context, index) {
              if (index >= state.chats.length) {
                return state.isPaginationLoading
                    ? const PaginationLoader()
                    : const SizedBox.shrink();
              }
              return ChatItem(chatEntity: state.chats[index]);
            },
          ),
        );
      },
    );
  }
}
