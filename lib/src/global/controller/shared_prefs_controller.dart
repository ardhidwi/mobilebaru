import 'package:car_workshop_flutter/src/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_flutter/src/core/core.dart';
import 'package:car_workshop_flutter/src/global/repo/shared_prefs_repo.dart';
import 'package:car_workshop_flutter/src/models/user.dart';

final sharedPrefsControllerPovider = Provider((ref) {
  final repo = ref.watch(sharedPrefsRepoProvider);
  return SharedPrefsController(repo: repo);
});

class SharedPrefsController {
  final SharedPrefsRepo _repo;

  SharedPrefsController({required SharedPrefsRepo repo}) : _repo = repo;

  Future<String?> getCookie() async {
    return _repo.getCookie();
  }

  FutureVoid setCookie({required String cookie}) async {
    await _repo.setCookie(cookie);
  }

  Future<UserModel?> getUser() async {
    return _repo.getCurrentUser();
  }

  FutureVoid setUser({required UserModel user}) async {
    _repo.setCurrentUser(user);
  }

  FutureVoid clear() async {
    return _repo.clear();
  }
}
