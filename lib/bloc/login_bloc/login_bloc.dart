// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clouddisk_login_form/api/api_header.dart';
import 'package:clouddisk_login_form/api/api_url.dart';
import 'package:clouddisk_login_form/api/requests/login_req.dart';
import 'package:clouddisk_login_form/api/responses/login_res.dart';
import 'package:clouddisk_login_form/global_variable/global_variable.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is ClickedLoginEvent) {
        emit(LoginLoading());
        final value = await api.post(loginUrl, event.req.getMap(), loginHeader);
        var loginRes = LogInResponse(value);
        if (loginRes.success == true) {
          prefs.setSession(loginRes.session); //save session vào preference
          prefs.setHmailKey(loginRes.hmailkey); //save hmailKey vào preference
          emit(LoginSuccessLoaded(loginRes));
        } else {
          emit(const LoginFailLoaded("Không đăng nhập được"));
        }
      }
    });
  }
}

// sortBloc bo ngoai cung de shared bloc
// 
