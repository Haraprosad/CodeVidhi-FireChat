import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codevidhi_firechat/core/utils/throttle_droppable.dart';
import 'package:codevidhi_firechat/features/chats/presentation/bloc/chats_state.dart';
import 'package:codevidhi_firechat/core/network/bloc/base_bloc.dart';
import 'package:codevidhi_firechat/features/chats/domain/usecases/get_chats_usecase.dart';
import 'package:codevidhi_firechat/features/chats/presentation/bloc/chats_event.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatsBloc extends BaseBloc<ChatsEvent, ChatsState> {
  final GetChatsUseCase _getChatsUseCase;
  static const int _postLimit = 20;

  ChatsBloc(this._getChatsUseCase) : super(const ChatsState()) {
    on<ChatsFetched>(_onFetchChats);
    on<ChatsLoadMore>(_onLoadMoreChats,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onFetchChats(
    ChatsFetched event,
    Emitter<ChatsState> emit,
  ) async {
    await handleApiCall(
      apiCall: () => _getChatsUseCase(start: 0, limit: _postLimit),
      onSuccess: (chats) {
        emit(state.copyWith(
          chats: chats,
          hasReachedMax: chats.length < _postLimit,
        ));
      },
      emit: emit,
    );
  }

  Future<void> _onLoadMoreChats(
    ChatsLoadMore event,
    Emitter<ChatsState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(isPaginationLoading: true));

    await handleApiCall(
      apiCall: () => _getChatsUseCase(
        start: state.chats.length,
        limit: _postLimit,
      ),
      onSuccess: (chats) {
        emit(state.copyWith(
          chats: [...state.chats, ...chats],
          hasReachedMax: chats.length < _postLimit,
          isPaginationLoading: false,
        ));
      },
      onError: (failure) {
        emit(state.copyWith(
            hasReachedMax: true, failure: failure, isPaginationLoading: false));
      },
      emit: emit,
      showLoader: false,
    );
  }
}
