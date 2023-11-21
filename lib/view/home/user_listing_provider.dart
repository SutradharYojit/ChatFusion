import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/model.dart';
import '../../services/api_constants.dart';
import '../../services/services.dart';

// RiverPod state management
final userList = StateNotifierProvider<UserData, List<UsersModel>>((ref) => UserData());

// used to get the list of blog data
class UserData extends StateNotifier<List<UsersModel>> {
  UserData() : super([]);

  final List<UsersModel> currentUser = [];
  final userPreferences = UserPreferences();

  Future getUsers() async {
    state.clear();
    userPreferences.getUserInfo();

    final data = await ApiServices().getApi(
      api: "${APIConstants.baseUrl}user/getUsers",
      body: {},
    );
    for (Map<String, dynamic> i in data) {
      state.add(UsersModel.fromJson(i));
    }
    log(state.length.toString());
    final current = state.where((element) => element.id == UserPreferences.userId).toList();
    state.remove(current.first); // remove the current user from the blogger list
    state.insert(0, current.first); // insert the current user in the first of the list
    state = [...state];
    return state;
  }
}
