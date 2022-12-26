part of 'send_file_bloc.dart';

abstract class SendFileState extends Equatable {
  const SendFileState();

  @override
  List<Object> get props => [];
}

class SendFileInitial extends SendFileState {}

class SendFileLoading extends SendFileState {}

class SendFileLoaded extends SendFileState {}
