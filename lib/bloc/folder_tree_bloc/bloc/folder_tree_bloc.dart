// ignore: depend_on_referenced_packages
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clouddisk_login_form/api/api_header.dart';
import 'package:clouddisk_login_form/api/api_url.dart';
import 'package:clouddisk_login_form/api/api_service.dart';
import 'package:equatable/equatable.dart';

import 'package:clouddisk_login_form/models/item.dart';
import 'package:flutter/material.dart';

part 'folder_tree_event.dart';
part 'folder_tree_state.dart';

class FolderTreeBloc extends Bloc<FolderTreeEvent, FolderTreeState> {
  AuthApi api = AuthApi();
  FolderTreeBloc() : super(FolderTreeInitial()) {
    on<FolderTreeEvent>((event, emit) async {
      if (event is LoadEvent) {
        folders = [];
        emit(FolderTreeLoading());
        final resp =
            await api.get(getFolderUrl("file", event.id), folderHeader);
        final json = jsonDecode(resp);
        final List itemList = json["files"];
        folders =
            itemList.map((folderJson) => Folder.fromJson(folderJson)).toList();
        if (event.id == "") {
          foldersRoot = folders;
          addColorandIcon();
        } else {
          for (var element in folders) {
            // print(
            //     "${element.regdate}....${element.formatBytes(element.size, 1)}");
            element.addColorandIcon(Colors.indigo, Icons.folder);
          }
        }
        emit(FolderTreeLoaded(folders));
      }
    });
  }
}
