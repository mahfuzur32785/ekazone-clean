import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:ekayzone/modules/authentication/models/user_prfile_model.dart';
import 'package:ekayzone/modules/chat/model/chat_user_model.dart';
import 'package:ekayzone/modules/chat/model/message_model.dart';

class ChatModel extends Equatable{
  const ChatModel({
    required this.messages,
    required this.user,
    required this.users,
    this.selectedUser,
  });

  final List<MessageModel> messages;
  final UserProfileModel user;
  final List<ChatUsersModel> users;
  final UserProfileModel? selectedUser;

  ChatModel copyWith({
    List<MessageModel>? messages,
    UserProfileModel? user,
    List<ChatUsersModel>? users,
    UserProfileModel? selectedUser,
  }) =>
      ChatModel(
        messages: messages ?? this.messages,
        user: user ?? this.user,
        users: users ?? this.users,
        selectedUser: selectedUser ?? this.selectedUser,
      );

  factory ChatModel.fromJson(String str) => ChatModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatModel.fromMap(Map<String, dynamic> json) => ChatModel(
    messages: json["messages"] == null ? [] : List<MessageModel>.from(json["messages"].map((x) => MessageModel.fromMap(x))),
    user: UserProfileModel.fromMap(json["user"]),
    users: json["users"] == null ? [] : List<ChatUsersModel>.from(json["users"].map((x) => ChatUsersModel.fromMap(x))),
    selectedUser: json["selected_user"] == null ? null : UserProfileModel.fromMap(json["selected_user"]),
  );

  Map<String, dynamic> toMap() => {
    "messages": List<dynamic>.from(messages.map((x) => x.toMap())),
    "user": user,
    "users": List<dynamic>.from(users.map((x) => x.toMap())),
    "selected_user": selectedUser,
  };

  @override
  String toString() {
    return 'ChatModel(messages: $messages, user: $user, users: $users, selected_user: $selectedUser)';
  }

  @override
  List<Object> get props {
    return [
      messages,
      user,
      users,
      selectedUser!,
    ];
  }
}