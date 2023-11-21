import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/model.dart';
import '../../services/api_constants.dart';
import '../../services/services.dart';

final chatList = AutoDisposeStateNotifierProvider<ChatListing, List<ChatModel>>((ref) => ChatListing());

class ChatListing extends StateNotifier<List<ChatModel>> {
  ChatListing() : super([]);

  Future getChats({required List<String> ids}) async {
    state.clear();
    ids.sort();
    String chatRoomId = ids.join("_");
    final data = await ApiServices().getApi(
      api: "${APIConstants.baseUrl}message/getMessage",
      body: {
        "chatId":chatRoomId
      },
    );
    for (Map<String, dynamic> i in data) {
      state.add(ChatModel.fromJson(i));
    }
    log(state.length.toString());
    state = [...state];
    return state;
  }
}
