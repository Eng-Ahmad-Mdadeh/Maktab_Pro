class OfficeFile {
  int id;
  String path;
  String typeFile;

  OfficeFile({
    required this.id,
    required this.path,
    required this.typeFile,
  });

  factory OfficeFile.fromJson(Map<String, dynamic> json) => OfficeFile(
        id: json["id"],
        path: 'https://maktab.sa/${json["path"]}',
        typeFile: json["type_file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
        "type_file": typeFile,
      };

  static bool isLocal(String path, List<OfficeFile> files) {
    bool isLocal = true;
    for (OfficeFile file in files) {
      if (file.path == path) {
        isLocal = false;
      }
    }
    return isLocal;
  }
}
