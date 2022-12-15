// ignore: depend_on_referenced_packages
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clouddisk_login_form/api/api_header.dart';
import 'package:clouddisk_login_form/api/api_url.dart';
import 'package:clouddisk_login_form/api/api_service.dart';
import 'package:equatable/equatable.dart';

import 'package:clouddisk_login_form/models/item.dart';

part 'folder_tree_event.dart';
part 'folder_tree_state.dart';

class FolderTreeBloc extends Bloc<FolderTreeEvent, FolderTreeState> {
  AuthApi api = AuthApi();
  FolderTreeBloc() : super(FolderTreeInitial()) {
    on<FolderTreeEvent>((event, emit) async {
      if (event is LoadEvent) {
        emit(FolderTreeLoading());
        final resp =
            await api.get(getFolderUrl("file", event.id), folderHeader);
        final json = jsonDecode(resp);
        final List folderList = json["files"];
        folders = folderList
            .map((folderJson) => Folder.fromJson(folderJson))
            .toList();
        if (event.id == "") {
          foldersRoot = folders;
          addColorandIcon();
        }
        // else {
        //   late var folder;
        //   for (Item f in folders) {
        //     for (Folder f2 in foldersRoot) {
        //       if (f2.id == event.id) {
        //         folder = f2;
        //         break;
        //       }
        //     }
        //     if (f is Folder) {

        //     }
        //   }
        // }
        emit(FolderTreeLoaded(folders));
      }
    });
  }
}
