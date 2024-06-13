import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

import '../../../core/network/api_endpoints.dart';

class OfficeFile extends Equatable {
  final int? id;
  final String path;
  final String? typeFile;
  final VideoPlayerController? controller;

  const OfficeFile({
    this.id,
    required this.path,
    this.typeFile,
    this.controller,
  });

  factory OfficeFile.fromJson(Map<String, dynamic> json) {
    return OfficeFile(
      id: json["id"],
      path: json["path"],
      typeFile: json["type_file"],
      controller: json["type_file"] == 'video' ? VideoPlayerController.networkUrl(Uri.parse(ApiEndpoints.siteUrl + json["path"])) : null
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "path": path,
        "type_file": typeFile,
      };

  @override
  String toString() {
    return 'OfficeFile{id: $id, path: $path, typeFile: $typeFile}';
  }

  @override
  List<Object?> get props => [
        id,
        path,
        typeFile,
      ];

  OfficeFile copyWith({
    int? id,
    String? path,
    String? typeFile,
  }) {
    return OfficeFile(
      id: id ?? this.id,
      path: path ?? this.path,
      typeFile: typeFile ?? this.typeFile,
    );
  }

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
