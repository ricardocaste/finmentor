import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:finmentor/domain/models/user.dart';

class Utils {
  static User? getUser() {
    User? user;
    try {
      user =
          Get.find<User>(tag: 'user'); // Intenta obtener la instancia de User
    } catch (e) {
      if (kDebugMode) {
        print('User not found');
      }
    }
    return user; // Devuelve el usuario encontrado o null
  }

  static void setUser(User user) {
    try {
      Get.put<User>(user, tag: 'user'); // Establece la instancia de User
    } catch (e) {
      if (kDebugMode) {
        print('Error al establecer el usuario: $e');
      }
    }
  }
}
