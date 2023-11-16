import 'package:flutter_riverpod/flutter_riverpod.dart';

final participantsList = AutoDisposeStateNotifierProvider<UserData, List<String>>((ref) => UserData());

class UserData extends StateNotifier<List<String>> {
  UserData() : super([]);
  
  void add(String name) {
    state.add(name);
    state=[...state];
  }
  
  void remove(int index) {
    state.removeAt(index);
    state=[...state];
  }

}
