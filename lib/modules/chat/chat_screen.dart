import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:ekayzone/core/remote_urls.dart';
import 'package:ekayzone/core/router_name.dart';
import 'package:ekayzone/modules/chat/controller/chat_users_cubit/chat_users_cubit.dart';
import 'package:ekayzone/utils/constants.dart';
import 'package:ekayzone/utils/k_images.dart';
import 'package:ekayzone/utils/utils.dart';

import '../../utils/k_strings.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ChatUsersCubit>().getChatUsers());
  }
  @override
  Widget build(BuildContext context) {
    final chatBloc = context.read<ChatUsersCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Chats"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_outlined,color: Colors.white,),
        ),
      ),
    //   body: CardField(
    //     onCardChanged: (card) {
    //   if (kDebugMode) {
    //     print(card);
    //   }
    // },
    // ),
      body: BlocBuilder<ChatUsersCubit,ChatUsersState>(
        builder: (context,state) {
          if (state is ChatUsersStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ChatUsersStateError) {
            return Center(
              child: Text(
                state.errorMsg,
                style: const TextStyle(color: redColor),
              ),
            );
          }
          if (state is ChatUsersStateLoaded) {
            if (state.chatModel.users.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Empty Chat List"),
                  ],
                ),
              );
            }
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.chatDetails,arguments: state.chatModel.users[index].username);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: ashColor,
                                        backgroundImage: NetworkImage(
                                          "${RemoteUrls.rootUrl}${state.chatModel.users[index].image}",),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(state.chatModel.users[index].name,
                                            style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                height: 1),),
                                          Text(state.chatModel.users[index].lastMsg,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 13,
                                                height: 1),),
                                          Text(Utils.timeAgo(state.chatModel.users[index].lastUpdatedAt), style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13),),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Divider(
                                height: 1,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },childCount: state.chatModel.users.length),
                ),
              ],
            );
          }
          return const SizedBox();
        }
      ),
    );
  }
}
