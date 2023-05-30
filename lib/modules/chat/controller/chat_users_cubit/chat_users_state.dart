part of 'chat_users_cubit.dart';
abstract class ChatUsersState extends Equatable {
  const ChatUsersState();

  @override
  @override
  List<Object> get props => [];
}

class ChatUsersStateLoading extends ChatUsersState {
  const ChatUsersStateLoading();
}

class ChatUsersStateError extends ChatUsersState {
  final String errorMsg;
  final int statusCode;

  const ChatUsersStateError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class ChatUsersStateLoaded extends ChatUsersState {
  final ChatModel chatModel;
  const ChatUsersStateLoaded(this.chatModel);

  @override
  List<Object> get props => [chatModel];
}