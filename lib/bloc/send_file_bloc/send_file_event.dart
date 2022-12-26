part of 'send_file_bloc.dart';

abstract class SendFileEvent extends Equatable {
  const SendFileEvent();

  @override
  List<Object> get props => [];
}

class CLickedSendEvent extends SendFileEvent {
  final SendFile sendFile;
  const CLickedSendEvent(this.sendFile);
  @override
  List<Object> get props => [sendFile];
}
