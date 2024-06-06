import 'package:equatable/equatable.dart';

class GeneralSettingsModel extends Equatable {
  const GeneralSettingsModel({
    required this.siteTitleAr,
    required this.siteTitleEn,
    required this.siteDescAr,
    required this.siteDescEn,
    required this.siteKeywordsAr,
    required this.siteKeywordsEn,
    required this.siteUrl,
    required this.siteStatus,
    required this.logo,
    required this.imageDashboard,
    required this.imageFavorite,
    required this.iconBrowser,
  });

  final String? siteTitleAr;
  final String? siteTitleEn;
  final String? siteDescAr;
  final String? siteDescEn;
  final String? siteKeywordsAr;
  final String? siteKeywordsEn;
  final String? siteUrl;
  final String? siteStatus;
  final String? logo;
  final String? imageDashboard;
  final String? imageFavorite;
  final String? iconBrowser;

  GeneralSettingsModel copyWith({
    String? siteTitleAr,
    String? siteTitleEn,
    String? siteDescAr,
    String? siteDescEn,
    String? siteKeywordsAr,
    String? siteKeywordsEn,
    String? siteUrl,
    String? siteStatus,
    String? logo,
    String? imageDashboard,
    String? imageFavorite,
    String? iconBrowser,
  }) {
    return GeneralSettingsModel(
      siteTitleAr: siteTitleAr ?? this.siteTitleAr,
      siteTitleEn: siteTitleEn ?? this.siteTitleEn,
      siteDescAr: siteDescAr ?? this.siteDescAr,
      siteDescEn: siteDescEn ?? this.siteDescEn,
      siteKeywordsAr: siteKeywordsAr ?? this.siteKeywordsAr,
      siteKeywordsEn: siteKeywordsEn ?? this.siteKeywordsEn,
      siteUrl: siteUrl ?? this.siteUrl,
      siteStatus: siteStatus ?? this.siteStatus,
      logo: logo ?? this.logo,
      imageDashboard: imageDashboard ?? this.imageDashboard,
      imageFavorite: imageFavorite ?? this.imageFavorite,
      iconBrowser: iconBrowser ?? this.iconBrowser,
    );
  }

  factory GeneralSettingsModel.fromJson(Map<String, dynamic> json){
    return GeneralSettingsModel(
      siteTitleAr: json["site_title_ar"],
      siteTitleEn: json["site_title_en"],
      siteDescAr: json["site_desc_ar"],
      siteDescEn: json["site_desc_en"],
      siteKeywordsAr: json["site_keywords_ar"],
      siteKeywordsEn: json["site_keywords_en"],
      siteUrl: json["site_url"],
      siteStatus: json["site_status"],
      logo: json["logo"],
      imageDashboard: json["image_dashboard"],
      imageFavorite: json["image_favorite"],
      iconBrowser: json["icon_browser"],
    );
  }

  Map<String, dynamic> toJson() => {
    "site_title_ar": siteTitleAr,
    "site_title_en": siteTitleEn,
    "site_desc_ar": siteDescAr,
    "site_desc_en": siteDescEn,
    "site_keywords_ar": siteKeywordsAr,
    "site_keywords_en": siteKeywordsEn,
    "site_url": siteUrl,
    "site_status": siteStatus,
    "logo": logo,
    "image_dashboard": imageDashboard,
    "image_favorite": imageFavorite,
    "icon_browser": iconBrowser,
  };

  @override
  String toString(){
    return "$siteTitleAr, $siteTitleEn, $siteDescAr, $siteDescEn, $siteKeywordsAr, $siteKeywordsEn, $siteUrl, $siteStatus, $logo, $imageDashboard, $imageFavorite, $iconBrowser, ";
  }

  @override
  List<Object?> get props => [
    siteTitleAr, siteTitleEn, siteDescAr, siteDescEn, siteKeywordsAr, siteKeywordsEn, siteUrl, siteStatus, logo, imageDashboard, imageFavorite, iconBrowser, ];
}
