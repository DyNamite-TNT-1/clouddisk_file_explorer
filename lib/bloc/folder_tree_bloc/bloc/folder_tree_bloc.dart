// ignore: depend_on_referenced_packages
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clouddisk_login_form/api/api_header.dart';
import 'package:clouddisk_login_form/api/api_url.dart';
import 'package:clouddisk_login_form/api/api_service.dart';
import 'package:clouddisk_login_form/global_variable/global_variable.dart';
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
        print(1);
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
            element.addColorandIcon(Colors.indigo, Icons.folder);
          }
        }
        isClickedDefault = false;
        emit(FolderTreeLoaded(folders));
      }
      if (event is SortEvent) {
        print(2);

        folders = [];
        emit(FolderTreeLoading());
        final resp = await api.get(
            sortFolderUrl("file", event.id, event.sort, event.order),
            folderHeader);
        final json = jsonDecode(resp);
        final List itemList = json["files"];
        folders =
            itemList.map((folderJson) => Folder.fromJson(folderJson)).toList();
        if (event.id == "") {
          foldersRoot = folders;
          addColorandIcon();
        } else {
          for (var element in folders) {
            element.addColorandIcon(Colors.indigo, Icons.folder);
          }
        }
        // sau khi sort sẽ cho isSort = false để qua màn hình khác không bị auto sort
        isSort = false;
        emit(FolderTreeLoaded(folders));
      }
    });
  }
}
