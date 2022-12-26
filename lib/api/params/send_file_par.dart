class SendFile {
  final String files;
  final String mode;
  SendFile(this.files, this.mode);
  Map getMap() {
    return {
      "files": files,
      "mode": mode,
    };
  }
}
