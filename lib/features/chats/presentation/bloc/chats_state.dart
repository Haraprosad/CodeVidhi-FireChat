import 'package:equatable/equatable.dart';
import 'package:codevidhi_firechat/core/network/bloc/base_bloc_state.dart';
import 'package:codevidhi_firechat/core/network/error_handling/models/api_call_failure_model.dart';
import 'package:codevidhi_firechat/features/chats/domain/entities/chats_entity.dart';

final class ChatsState extends Equatable implements BaseBlocState {
  /// List of chats retrieved
  final List<ChatsEntity> chats;

  /// Indicates if all chats have been loaded
  final bool hasReachedMax;

  /// Indicates if an API request is currently in progress
  @override
  final bool isLoading;

  /// Indicates if pagination loading is in progress
  final bool isPaginationLoading;

  /// Contains any error details related to network requests
  @override
  final ApiCallFailureModel? failure;

  /// Constructor with default values and optional parameters
  const ChatsState({
    this.chats = const <ChatsEntity>[],
    this.hasReachedMax = false,
    this.isLoading = false,
    this.isPaginationLoading = false,
    this.failure,
  });

  /// Creates a copy of the current state with optional parameter overrides
  @override
  ChatsState copyWith({
    List<ChatsEntity>? chats,
    bool? hasReachedMax,
    bool? isLoading,
    bool? isPaginationLoading,
    ApiCallFailureModel? failure,
  }) {
    return ChatsState(
      chats: chats ?? this.chats,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      failure: failure ?? this.failure,
    );
  }

  /// Implements Equatable to allow state comparison
  @override
  List<Object?> get props =>
      [chats, hasReachedMax, isLoading, isPaginationLoading, failure];

  /// Provides a string representation of the state
  @override
  String toString() {
    return 'PostState { '
        'chats: ${chats.length}, '
        'hasReachedMax: $hasReachedMax, '
        'isLoading: $isLoading, '
        'isPaginationLoading: $isPaginationLoading, '
        'failure: $failure '
        '}';
  }
}
