import 'package:car_workshop_flutter/src/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Watch the [authTokenProvider] to check if the user is logged in.
final authTokenProvider = StateProvider<String?>((ref) => null);

final currentUserProvider = StateProvider<UserModel?>((ref) => null);
