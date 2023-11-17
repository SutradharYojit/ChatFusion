import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectPeopleList = StateNotifierProvider<SelectedPeople, List<String>>((ref) => SelectedPeople());

class SelectedPeople extends StateNotifier<List<String>> {
  SelectedPeople() : super([]);
  
  void add(String name) {
    state.add(name);
    state=[...state];
  }
  
  void removeAt(int index) {
    state.removeAt(index);
    state=[...state];
  }
  void remove(String name) {
    state.remove(name);
    state=[...state];
  }
}


final usersList = AutoDisposeStateNotifierProvider<Users, List<String>>((ref) => Users());

class Users extends StateNotifier<List<String>> {
  Users() : super([
    'Jimmy Suthar',
    'Emily Johnson',
    'Michael Davis',
    'Sarah Miller',
    'Christopher Brown',
    'Jessica Wilson',
    'Brian Taylor',
    'Olivia Anderson',
    'David Martinez',
    'Lauren Thomas',
    'Daniel Jackson',
    'Ava White',
    'Matthew Harris',
    'Emma Turner',
    'Andrew Clark',
    'Sophia Garcia',
    'Kevin Moore',
    'Grace Lewis',
    'Ryan Carter',
    'Mia Walker',
    'Ethan Wright',
    'Chloe Robinson',
    'Alexander Young',
    'Lily Hall',
    'Nicholas Baker',
    'Zoe Mitchell',
    'Tyler Cooper',
    'Avery Turner',
    'Brandon Garcia',
  ]);

  void add(String name) {
    state.add(name);
    state=[...state];
  }

  void remove(int index) {
    state.removeAt(index);
    state=[...state];
  }
}
