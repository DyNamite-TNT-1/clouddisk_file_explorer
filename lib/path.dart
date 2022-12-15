List<String> listPaths = [""];

class Path {
  String path = "...";
  String truePath(List<String> listPaths) {
    if (listPaths.elementAt(0) != "") {
      listPaths.insert(0, "");
    }
    return path + listPaths.join("/");
  }
}

Path path = Path();
