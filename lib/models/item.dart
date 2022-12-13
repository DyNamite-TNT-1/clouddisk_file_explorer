class Folder {
  final String id;
  final String text;
  Folder(
    this.id,
    this.text,
  );

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      json['id'] as String,
      json['text'] as String,
    );
  }

  @override
  String toString() => 'Folder(id: $id, text: $text)';
}

List<Folder> folders = [];
List<Folder> subFolders = [];
