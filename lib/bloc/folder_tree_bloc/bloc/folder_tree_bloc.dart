// ignore: depend_on_referenced_packages
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clouddisk_login_form/api/api_url.dart';
import 'package:clouddisk_login_form/global_variable/global_variable.dart';
import 'package:equatable/equatable.dart';

import 'package:clouddisk_login_form/models/item.dart';
import 'package:flutter/material.dart';

part 'folder_tree_event.dart';
part 'folder_tree_state.dart';

class FolderTreeBloc extends Bloc<FolderTreeEvent, FolderTreeState> {
  FolderTreeBloc() : super(FolderTreeInitial()) {
    on<FolderTreeEvent>((event, emit) async {
      if (event is LoadEvent) {
        ListFolders folders = ListFolders(listFolders: []);
        if (!isClosed) {
          emit(FolderTreeLoading());
        }
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
        final resp = await api.get(getFolderUrl("file", event.id), fileHeader);

        late dynamic json;
        if (resp.isNotEmpty) {
          json = jsonDecode(resp);
        }
        final List itemList = json["files"];
        folders = ListFolders(
            listFolders: itemList
                .map((folderJson) => Folder.fromJson(folderJson))
                .toList());
        if (event.id == "") {
          folders.listFolders[0]
              .addColorandIcon(Colors.blueAccent.shade400, Icons.folder);
          folders.listFolders[1]
              .addColorandIcon(Colors.green.shade900, Icons.cloud_sync);
          folders.listFolders[2]
              .addColorandIcon(Colors.orange.shade400, Icons.snippet_folder);
          folders.listFolders[3]
              .addColorandIcon(Colors.purple.shade800, Icons.share);
          folders.listFolders[4]
              .addColorandIcon(Colors.pink.shade300, Icons.star);
          folders.listFolders[5]
              .addColorandIcon(Colors.brown, Icons.campaign_outlined);
          folders.listFolders[6]
              .addColorandIcon(Colors.teal.shade700, Icons.source);
          folders.listFolders[7]
              .addColorandIcon(Colors.red.shade900, Icons.delete_outline);
        } else {
          for (var element in folders.listFolders) {
            element.addColorandIcon(Colors.indigo, Icons.folder);
          }
        }
        // isClickedDefault = false;
        if (!isClosed) {
          emit(FolderTreeLoaded(folders.listFolders));
        }
      }
      if (event is SortEvent) {
        ListFolders folders = ListFolders(listFolders: []);
        if (!isClosed) {
          emit(FolderTreeLoading());
        }
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
            sortFolderUrl("file", event.id, event.sort, event.order),
            fileHeader);
        final json = jsonDecode(resp);
        final List itemList = json["files"];
        folders = ListFolders(
            listFolders: itemList
                .map((folderJson) => Folder.fromJson(folderJson))
                .toList());
        if (event.id == "") {
          folders.listFolders[0]
              .addColorandIcon(Colors.blueAccent.shade400, Icons.folder);
          folders.listFolders[1]
              .addColorandIcon(Colors.green.shade900, Icons.cloud_sync);
          folders.listFolders[2]
              .addColorandIcon(Colors.orange.shade400, Icons.snippet_folder);
          folders.listFolders[3]
              .addColorandIcon(Colors.purple.shade800, Icons.share);
          folders.listFolders[4]
              .addColorandIcon(Colors.pink.shade300, Icons.star);
          folders.listFolders[5]
              .addColorandIcon(Colors.brown, Icons.campaign_outlined);
          folders.listFolders[6]
              .addColorandIcon(Colors.teal.shade700, Icons.source);
          folders.listFolders[7]
              .addColorandIcon(Colors.red.shade900, Icons.delete_outline);
        } else {
          for (var element in folders.listFolders) {
            element.addColorandIcon(Colors.indigo, Icons.folder);
          }
        }
        if (!isClosed) {
          emit(FolderTreeLoaded(folders.listFolders));
        }
      }
    });
  }
}
