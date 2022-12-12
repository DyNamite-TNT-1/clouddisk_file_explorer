// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:clouddisk_login_form/models/item.dart';

part 'folder_tree_event.dart';
part 'folder_tree_state.dart';

class FolderTreeBloc extends Bloc<FolderTreeEvent, FolderTreeState> {
  List<int> ids = []; // Tạo một list gồm những id
  FolderTreeBloc() : super(FolderTreeInitial()) {
    on<FolderTreeEvent>((event, emit) {
      if (event is LoadEvent) {
        final id = event.id;
        for (Folder folder in folders) {
          if (folder.id == id) {
            ids.add(id); // Lưu những id đã đi qua vào ids
            emit(FolderRootLoaded(folder.children));
            break;
          }
        }
      }
      if (event is BackEvent) {
        //ids.last tức là id của folder đang hiển thị
        if (ids.last != 0) {
          //nếu folder đang hiển thị không phải folder gốc thì sẽ xóa nó đi
          ids.removeLast();
        } else {
          // nếu đang ở folder gốc thì clear toàn bộ ids và gán phần tử đầu tiên là folder gốc
          ids.clear();
          ids.add(0);
        }
        final preId = ids[ids.length - 1];
        //preId lưu trữ id của folder trước folder hiện tại, nếu id đang = 0 thì ids chỉ có mỗi một phần tử là 0, vì đã clear ở trên
        for (Folder folder in folders) {
          if (folder.id == preId) {
            emit(FolderRootLoaded(folder.children));
            break;
          }
        }
      }
    });
  }
}
