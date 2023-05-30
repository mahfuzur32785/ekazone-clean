part of 'message_cubit.dart';
abstract class MessageState extends Equatable {
  const MessageState();

  @override
  @override
  List<Object> get props => [];
}

class MessageStateLoading extends MessageState {
  const MessageStateLoading();
}
class MessageStateSendLoading extends MessageState {
  const MessageStateSendLoading();
}

class MessageStateError extends MessageState {
  final String errorMsg;
  final int statusCode;

  const MessageStateError(this.errorMsg, this.statusCode);

  @override
  List<Object> get props => [errorMsg, statusCode];
}

class MessageStateLoaded extends MessageState {
  final ChatModel chatModel;
  const MessageStateLoaded(this.chatModel);

  @override
  List<Object> get props => [chatModel];
}
class MessageStateSendLoaded extends MessageState {
  final List<MessageModel> messageList;
  const MessageStateSendLoaded(this.messageList);

  @override
  List<Object> get props => [messageList];
}