// ignore: depend_on_referenced_packages
import 'dart:convert';
import 'dart:ffi';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:clouddisk_login_form/api/api_header.dart';
import 'package:clouddisk_login_form/api/api_url.dart';
import 'package:clouddisk_login_form/api/api_service.dart';
import 'package:equatable/equatable.dart';

import 'package:clouddisk_login_form/models/item.dart';

part 'folder_tree_event.dart';
part 'folder_tree_state.dart';

List<String> ids = [""];

class FolderTreeBloc extends Bloc<FolderTreeEvent, FolderTreeState> {
  AuthApi api = AuthApi();
  FolderTreeBloc() : super(FolderTreeInitial()) {
    on<FolderTreeEvent>((event, emit) async {
      if (event is LoadEvent) {
        for (Folder f in folders) {
          if (f.id == event.id && !f.text.contains(".")) {
            ids.add(f.text);
          }
        }
        emit(FolderTreeLoading());
        final resp =
            await api.get(getFolderUrl("file", event.id), folderHeader);
        final json = jsonDecode(resp);
        final List folderList = json["files"];
        folders = folderList
            .map((folderJson) => Folder.fromJson(folderJson))
            .toList();
        // final id = event.id;
        // print(event.id);

        // ids.add(id);
        print(ids);
        emit(FolderTreeLoaded(folders));
      }
      if (event is BackEvent) {
        //ids.last tức là id của folder đang hiển thị
        if (ids.last != "") {
          //nếu folder đang hiển thị không phải folder gốc thì sẽ xóa nó đi
          ids.removeLast();
        } else {
          // nếu đang ở folder gốc thì clear toàn bộ ids và gán phần tử đầu tiên là folder gốc
          ids.clear();
          ids.add("");
        }
        // final preId = ids[ids.length - 1];
        // //preId lưu trữ id của folder trước folder hiện tại, nếu id đang = 0 thì ids chỉ có mỗi một phần tử là 0, vì đã clear ở trên
        // for (Folder folder in folders) {
        //   if (folder.id == preId) {
        //     emit(FolderRootLoaded(folder.children));
        //     break;
        //   }
        // }
      }
    });
  }
}
