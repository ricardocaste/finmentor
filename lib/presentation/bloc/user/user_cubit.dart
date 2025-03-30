import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:finmentor/domain/models/user.dart';
import 'package:finmentor/domain/repositories/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepository) : super(UserInitial());
  final UserRepository userRepository;
  StreamSubscription? _userSubscription;

  void resetUser() async {
    try {
      Get.delete<User>(tag: 'user');
      _userSubscription?.cancel();
      emit(UserInitial());
    } catch (e) {
      emit(UserInitial());
    }
  }

  Future<User?> getUser(String uid) async {
    try {
      return await userRepository.getAppUser(uid);
    } catch (e) {
      return null;
    }
  }

  Future<void> loadUser(String uid) async {
    if (uid.isEmpty) return;
    try {
      _userSubscription?.cancel();
      _userSubscription = userRepository.getStreamAppUser(uid).listen((streamUser) {
        updateUser(streamUser);
      });
    } catch (e) {
      emit(UserInitial());
    }
  }

  Future<void> updateUser(User user) async {
    Get.delete<User>(tag: 'user');
    Get.put(user, tag: 'user');

    emit(UserLoaded(user));
  }

  void saveUserAvatar(User user) async {
    if (state is UserLoaded) {
      await userRepository.updateAvatarAppUser(user.uid, user.avatar ?? '');
    }
  }

  void editUserProfile(User user) async {
    emit(UserEditing());

    if (state is UserLoaded) {
      User userToUpdate = (state as UserLoaded).user;

      //userToUpdate.name = user.name;
      // userToUpdate. = event.lastName;
      // userToUpdate.country = event.country;

      await userRepository.updateAppUser(userToUpdate);
    }

    emit(UserEdited(user));
  }

  Future<void> userPurchased() async {
    emit(UserPurchasing());
    try {
      // User? user = Utils.getUser();
      // user!.hasPurchased = true;
      // await userRepository.purchase(user);
      // Utils.setUser(user);
      // emit(UserPurchased(user));
    } catch (e) {
    emit(UserPurchasedError());
    }
  }
}
