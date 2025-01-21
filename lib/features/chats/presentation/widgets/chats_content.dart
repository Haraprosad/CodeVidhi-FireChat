import 'package:codevidhi_firechat/features/chats/presentation/bloc/chats_bloc.dart';
import 'package:codevidhi_firechat/features/chats/presentation/bloc/chats_event.dart';
import 'package:codevidhi_firechat/features/chats/presentation/bloc/chats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_list_view.dart';

class ChatsContent extends StatefulWidget {
  const ChatsContent({super.key});

  @override
  State<ChatsContent> createState() => _ChatsContentState();
}

class _ChatsContentState extends State<ChatsContent> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event here to ensure it's triggered only once
    context.read<ChatsBloc>().add(ChatsFetched());
  }

  Future<void> _onRefresh() async {
    context.read<ChatsBloc>().add(ChatsFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: BlocBuilder<ChatsBloc, ChatsState>(
        builder: (context, state) {
          if (state.isLoading && state.chats.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.failure != null && state.chats.isEmpty) {
            return Center(
              child: Text(
                  state.failure?.translatedMessage ?? 'Something went wrong'),
            );
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: const ChatListView(),
          );
        },
      ),
    );
  }
}
