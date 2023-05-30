import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ekayzone/modules/chat/controller/chat_users_repository.dart';
import 'package:ekayzone/modules/chat/model/message_model.dart';

import '../../../authentication/controllers/login/login_bloc.dart';
import '../../model/chat_model.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit({
    required ChatRepository chatRepository,
    required LoginBloc loginBloc,
  })  : _chatRepository = chatRepository,
        _loginBloc = loginBloc,
        super(const MessageStateLoading());

  final ChatRepository _chatRepository;
  final LoginBloc _loginBloc;

  List<MessageModel> messageList = [];
  ChatModel? chatModel;
  var messageController = TextEditingController();

  bool isMe(id){
    if (id == _loginBloc.userInfo?.user.id) {
      return true;
    }
    return false;
  }

  Future<void> getUserMessage(username) async {
    if (_loginBloc.userInfo == null) {
      emit(const MessageStateError('Please sign in',401));
      return;
    }

    emit(const MessageStateLoading());

    final token = _loginBloc.userInfo!.accessToken;

    final result = await _chatRepository.getUsers(token,user: username);

    result.fold(
          (failure) {
        emit(MessageStateError(failure.message, failure.statusCode));
      },
          (success) {
            messageList = success.messages;
            chatModel = success;
        final currentState = MessageStateLoaded(success);
        emit(currentState);
      },
    );
  }

  Future<void> sendMessage(body,username) async {
    if (_loginBloc.userInfo == null) {
      emit(const MessageStateError('Please sign in',401));
      return;
    }

    emit(const MessageStateSendLoading());

    final token = _loginBloc.userInfo!.accessToken;

    final result = await _chatRepository.sendMessage(token,body,username);

    result.fold(
          (failure) {
        emit(MessageStateError(failure.message, failure.statusCode));
      },
          (success) {
        messageList = success;
        final currentState = MessageStateSendLoaded(success);
        messageController.text = '';
        emit(currentState);
        // getUserMessage(username);
      },
    );
  }
}
