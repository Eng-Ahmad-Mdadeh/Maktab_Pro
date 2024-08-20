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
    required this.vIos,
    required this.vAndroid,
    required this.vAppGallery,
    required this.vSite,
    required this.packageNameAndroidIndividual,
    required this.packageNameAndroidBusiness,
    required this.packageNameIosIndividual,
    required this.packageNameIosBusiness,
    required this.logo,
    required this.imageDashboard,
    required this.imageFavorite,
    required this.iconBrowser,

    required this.vIosBusiness,
    required this.vAndroidBusiness,
    required this.vAppGalleryBusiness,
  });

  final String? siteTitleAr;
  final String? siteTitleEn;
  final String? siteDescAr;
  final String? siteDescEn;
  final String? siteKeywordsAr;
  final String? siteKeywordsEn;
  final String? siteUrl;
  final String? siteStatus;
  final String? vIos;
  final String? vAndroid;
  final String? vAppGallery;
  final String? vSite;
  final String? packageNameAndroidIndividual;
  final String? packageNameAndroidBusiness;
  final String? packageNameIosIndividual;
  final String? packageNameIosBusiness;
  final String? logo;
  final String? imageDashboard;
  final String? imageFavorite;
  final String? iconBrowser;


  final String? vIosBusiness;
  final String? vAndroidBusiness;
  final String? vAppGalleryBusiness;

  GeneralSettingsModel copyWith({
    String? siteTitleAr,
    String? siteTitleEn,
    String? siteDescAr,
    String? siteDescEn,
    String? siteKeywordsAr,
    String? siteKeywordsEn,
    String? siteUrl,
    String? siteStatus,
    String? vIos,
    String? vAndroid,
    String? vAppGallery,
    String? vSite,
    String? packageNameAndroidIndividual,
    String? packageNameAndroidBusiness,
    String? packageNameIosIndividual,
    String? packageNameIosBusiness,
    String? logo,
    String? imageDashboard,
    String? imageFavorite,
    String? iconBrowser,
    String? vIosBusiness,
    String? vAndroidBusiness,
    String? vAppGalleryBusiness,
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
      vIos: vIos ?? this.vIos,
      vAndroid: vAndroid ?? this.vAndroid,
      vAppGallery: vAppGallery ?? this.vAppGallery,
      vSite: vSite ?? this.vSite,
      packageNameAndroidIndividual: packageNameAndroidIndividual ?? this.packageNameAndroidIndividual,
      packageNameAndroidBusiness: packageNameAndroidBusiness ?? this.packageNameAndroidBusiness,
      packageNameIosIndividual: packageNameIosIndividual ?? this.packageNameIosIndividual,
      packageNameIosBusiness: packageNameIosBusiness ?? this.packageNameIosBusiness,
      logo: logo ?? this.logo,
      imageDashboard: imageDashboard ?? this.imageDashboard,
      imageFavorite: imageFavorite ?? this.imageFavorite,
      iconBrowser: iconBrowser ?? this.iconBrowser,
      vIosBusiness: vIosBusiness ?? this.vIosBusiness,
      vAndroidBusiness: vAndroidBusiness ?? this.vAndroidBusiness,
      vAppGalleryBusiness: vAppGalleryBusiness ?? this.vAppGalleryBusiness,
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
      vIos: json["v_ios"],
      vAndroid: json["v_android"],
      vAppGallery: json["v_app_gallery"],
      vSite: json["v_site"],
      packageNameAndroidIndividual: json["package_name_android_individual"],
      packageNameAndroidBusiness: json["package_name_android_business"],
      packageNameIosIndividual: json["package_name_ios_individual"],
      packageNameIosBusiness: json["package_name_ios_business"],
      logo: json["logo"],
      imageDashboard: json["image_dashboard"],
      imageFavorite: json["image_favorite"],
      iconBrowser: json["icon_browser"],
      vIosBusiness: json["v_ios_business"],
      vAndroidBusiness: json["v_android_business"],
      vAppGalleryBusiness: json["v_app_gallery_business"],
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
    "v_ios": vIos,
    "v_android": vAndroid,
    "v_app_gallery": vAppGallery,
    "v_site": vSite,
    "package_name_android_individual": packageNameAndroidIndividual,
    "package_name_android_business": packageNameAndroidBusiness,
    "package_name_ios_individual": packageNameIosIndividual,
    "package_name_ios_business": packageNameIosBusiness,
    "logo": logo,
    "image_dashboard": imageDashboard,
    "image_favorite": imageFavorite,
    "icon_browser": iconBrowser,
    "v_ios_business": vIosBusiness,
    "v_android_business": vAndroidBusiness,
    "v_app_gallery_business": vAppGalleryBusiness,
  };

  @override
  String toString(){
    return "$siteTitleAr, $siteTitleEn, $siteDescAr, $siteDescEn, $siteKeywordsAr, $siteKeywordsEn, $siteUrl, $siteStatus, $vIos, $vAndroid, $vAppGallery, $vSite, $packageNameAndroidIndividual, $packageNameAndroidBusiness, $packageNameIosIndividual, $packageNameIosBusiness, $logo, $imageDashboard, $imageFavorite, $iconBrowser, ";
  }

  @override
  List<Object?> get props => [
    siteTitleAr, siteTitleEn, siteDescAr, siteDescEn, siteKeywordsAr, siteKeywordsEn, siteUrl, siteStatus, vIos, vAndroid, vAppGallery, vSite, packageNameAndroidIndividual, packageNameAndroidBusiness, packageNameIosIndividual, packageNameIosBusiness, logo, imageDashboard, imageFavorite, iconBrowser, ];
}
