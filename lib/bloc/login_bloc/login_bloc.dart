// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clouddisk_login_form/api/api_header.dart';
import 'package:clouddisk_login_form/api/api_service.dart';
import 'package:clouddisk_login_form/api/api_url.dart';
import 'package:clouddisk_login_form/api/request/login_req.dart';
import 'package:clouddisk_login_form/api/response/login_res.dart';
import 'package:clouddisk_login_form/main.dart';
import 'package:clouddisk_login_form/models/user.dart';
import 'package:equatable/equatable.dart';

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
          prefs.setSession(user.session); //save session vào preference
          prefs.setHmailKey(user.hmailKey); //save hmailKey vào preference
          emit(LoginSuccessLoaded(loginRes));
        } else {
          emit(const LoginFailLoaded("Không đăng nhập được"));
        }
      }
    });
  }
}