import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/chat/controller/chat_users_repository.dart';

import '../../../authentication/controllers/login/login_bloc.dart';
import '../../model/chat_model.dart';

part 'chat_users_state.dart';

class ChatUsersCubit extends Cubit<ChatUsersState> {
  ChatUsersCubit({
    required ChatRepository chatRepository,
    required LoginBloc loginBloc,
  })  : _chatRepository = chatRepository,
        _loginBloc = loginBloc,
        super(const ChatUsersStateLoading());

  final ChatRepository _chatRepository;
  final LoginBloc _loginBloc;

  Future<void> getChatUsers() async {
    if (_loginBloc.userInfo == null) {
      emit(const ChatUsersStateError('Please sign in',401));
      return;
    }

    emit(const ChatUsersStateLoading());

    final token = _loginBloc.userInfo!.accessToken;

    final result = await _chatRepository.getUsers(token,);

    result.fold(
          (failure) {
        emit(ChatUsersStateError(failure.message, failure.statusCode));
      },
          (success) {
        final currentState = ChatUsersStateLoaded(success);
        emit(currentState);
      },
    );
  }
}
