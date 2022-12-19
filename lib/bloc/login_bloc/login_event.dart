part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ClickedLoginEvent extends LoginEvent {
  final LogInRequest req;
  const ClickedLoginEvent(this.req);
  @override
  List<Object> get props => [req];
}
