// ignore: depend_on_referenced_packages
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clouddisk_login_form/global_variable/global_variable.dart';
import 'package:equatable/equatable.dart';

import 'package:clouddisk_login_form/api/api_url.dart';
import 'package:clouddisk_login_form/api/params/send_file_par.dart';
import 'package:clouddisk_login_form/api/responses/send_file_res.dart';

part 'send_file_event.dart';
part 'send_file_state.dart';

class SendFileBloc extends Bloc<SendFileEvent, SendFileState> {
  SendFileBloc() : super(SendFileInitial()) {
    on<SendFileEvent>((event, emit) async {
      if (event is CLickedSendEvent) {
        emit(SendFileLoading());
        final String session = await prefs.getSession();
        final String hmailKey = await prefs.getHmailKey();
        List<String> cookie = [
          ";HANBIRO_GW=$session",
          "hmail_key=$hmailKey",
          "cook=kie",
        ];
        final fileHeader = {
          "Cookie": cookie.join(";"),
        };
        final resp = await api.get(
            sendFileUrl(
                event.sendFile.convertListToString(), event.sendFile.mode),
            fileHeader);
        var json = jsonDecode(resp);
        var sendFileRes = SendFileResponse(json);
        print(sendFileRes.toString());
        listMapChecked.clear;
        emit(SendFileLoaded());
      }
    });
  }
}
