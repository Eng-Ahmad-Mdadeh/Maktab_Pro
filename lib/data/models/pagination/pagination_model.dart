import 'package:equatable/equatable.dart';

class PaginationModel extends Equatable {
  const PaginationModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final num? currentPage;
  final List<dynamic> data;
  final String? firstPageUrl;
  final num? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String? path;
  final String? perPage;
  final String? prevPageUrl;
  final num? to;
  final num? total;

  PaginationModel copyWith({
    num? currentPage,
    List<dynamic>? data,
    String? firstPageUrl,
    num? from,
    int? lastPage,
    String? lastPageUrl,
    List<Link>? links,
    String? nextPageUrl,
    String? path,
    String? perPage,
    String? prevPageUrl,
    num? to,
    num? total,
  }) {
    return PaginationModel(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      firstPageUrl: firstPageUrl ?? this.firstPageUrl,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      lastPageUrl: lastPageUrl ?? this.lastPageUrl,
      links: links ?? this.links,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      path: path ?? this.path,
      perPage: perPage ?? this.perPage,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }

  factory PaginationModel.fromJson(Map<String, dynamic> json){
    return PaginationModel(
      currentPage: json["current_page"],
      data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      lastPageUrl: json["last_page_url"],
      links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
      nextPageUrl: json["next_page_url"],
      path: json["path"],
      perPage: json["per_page"],
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data.map((x) => x).toList(),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links.map((x) => x.toJson()).toList(),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };

  @override
  String toString(){
    return "$currentPage, $data, $firstPageUrl, $from, $lastPage, $lastPageUrl, $links, $nextPageUrl, $path, $perPage, $prevPageUrl, $to, $total, ";
  }

  @override
  List<Object?> get props => [
    currentPage, data, firstPageUrl, from, lastPage, lastPageUrl, links, nextPageUrl, path, perPage, prevPageUrl, to, total, ];
}

class Link extends Equatable {
  const Link({
    required this.url,
    required this.label,
    required this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

  Link copyWith({
    String? url,
    String? label,
    bool? active,
  }) {
    return Link(
      url: url ?? this.url,
      label: label ?? this.label,
      active: active ?? this.active,
    );
  }

  factory Link.fromJson(Map<String, dynamic> json){
    return Link(
      url: json["url"],
      label: json["label"],
      active: json["active"],
    );
  }

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };

  @override
  String toString(){
    return "$url, $label, $active, ";
  }

  @override
  List<Object?> get props => [
    url, label, active, ];
}