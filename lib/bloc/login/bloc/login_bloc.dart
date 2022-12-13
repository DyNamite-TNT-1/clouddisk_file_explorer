// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clouddisk_login_form/models/user.dart';
import 'package:equatable/equatable.dart';

import 'package:clouddisk_login_form/api/auth.dart';
import 'package:clouddisk_login_form/models/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthApi api = AuthApi();
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is ClickedLoginEvent) {
        emit(LoginLoading());
        final value = await api.post(loginUrl, event.req.getMap(), loginHeader);
        var loginRes = LogInResponse(value);
        if (loginRes.success == true) {
          user.hmailKey = loginRes.hmailkey;
          user.session = loginRes.session;
          emit(LoginSuccessLoaded(loginRes));
        } else {
          emit(const LoginFailLoaded("Không đăng nhập được"));
        }
      }
    });
  }
}
