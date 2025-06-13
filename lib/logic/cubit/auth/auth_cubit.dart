import 'dart:async';

import 'package:chatapp/data/repository/auth_repository.dart';
import 'package:chatapp/logic/cubit/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User?>? _authStateSubscription;

  AuthCubit({
    required AuthRepository authRepository,
    required this._authStateSubscription,
  });
}
