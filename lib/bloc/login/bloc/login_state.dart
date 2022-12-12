part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccessLoaded extends LoginState {
  final LogInResponse res;
  const LoginSuccessLoaded(this.res);
  @override
  List<Object> get props => [res];
}

class LoginFailLoaded extends LoginState {
  final String error;
  const LoginFailLoaded(this.error);
  @override
  List<Object> get props => [error];
}
