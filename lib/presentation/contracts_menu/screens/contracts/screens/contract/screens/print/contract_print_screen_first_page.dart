import 'package:maktab_lessor/core/extension/date_time_extension.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';

import '../../../../../../../../data/models/contract/contract_model.dart';
import '../../../../../../../resources/app_colors.dart';

class ContractPrintFirstPageScreen extends StatelessWidget {
  final ContractModel contractModel;
  final Font font;
  final Font materialFont;
  final ImageProvider logo;

  ContractPrintFirstPageScreen(
    this.contractModel, {
    required this.font,
    required this.materialFont,
    required this.logo,
  });

  @override
  Widget build(Context context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PdfText("عقد ايجار",
                  font: font, size: 25, color: AppColors.darkGreen.value),
              PdfText(
                "Tenancy Contract",
                font: font,
                size: 19,
              ),
            ]),
            Image(logo, width: 100, height: 100),
          ],
        ),
        SizedBox(height: 30.0),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.darkGreen.value),
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PdfText("بيانات العقد",
                  font: font, color: AppColors.white.value, size: 15),
              PdfText("Contract Data",
                  font: font, color: AppColors.white.value, size: 15),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.white.value),
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: buildRowWithTwoOptions(title1: "نوع العقد:",
            value1: contractModel.contractType ?? "",
            title2: "رقم سجل العقد:",
            value2: contractModel.recordNumber ?? '',
            colorValue: AppColors.black.value
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.lGrey.value),
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: Row(children: [
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PdfText("تاريخ ابرام العقد:",
                        font: font, color: AppColors.black.value, size: 15),
                    PdfText(contractModel.createdAt?.dayFormatWithLocale('ar') ?? "",
                        font: font, color: AppColors.black.value, size: 15),
                  ],
                )),
            SizedBox(width: 20.h),
            Expanded(child: SizedBox()),
          ]),
        ),
        Container(
          width: double.infinity,
          color: PdfColor.fromInt(AppColors.white.value),
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: Column(children: [
            SizedBox(height: 5.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: PdfText("تاريخ بداية مدة الايجار:",
                      font: font, color: AppColors.black.value, size: 15),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: PdfText(contractModel.contractStartDate?.dayFormatWithLocale('ar') ?? "",
                      font: font, color: AppColors.black.value, size: 15),
                )
              ],
            ),
            SizedBox(height: 5.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PdfText("تاريخ نهاية مدة الايجار:",
                    font: font, color: AppColors.black.value, size: 15),
                PdfText(contractModel.contractEndDate?.dayFormatWithLocale('ar') ?? '',
                    font: font, color: AppColors.black.value, size: 15),
              ],
            ),
            SizedBox(height: 5.v),
          ]),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.darkGreen.value),
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PdfText("بيانات المؤجر",
                  font: font, color: AppColors.white.value, size: 15),
              PdfText("Lessor Data",
                  font: font, color: AppColors.white.value, size: 15),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.white.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: buildRowWithTwoOptions(title1: "الاسم:",
              value1: contractModel.lessorFullName ?? "",
              title2: "الجنسية:",
              value2: contractModel.lessorNationality ?? '',
              colorValue: AppColors.black.value
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.lGrey.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: buildRowWithTwoOptions(title1: "نوع الهوية:",
              value1: contractModel.lessorIdentityType ?? "",
              title2: "رقم الهوية:",
              value2: contractModel.lessorIdentityNum ?? '',
              colorValue: AppColors.black.value
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.white.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: buildRowWithTwoOptions(title1: "رقم الجوال:",
              value1: contractModel.lessorPhone ?? "",
              title2: "رقم الايبان:",
              value2: contractModel.lessorIban ?? '',
              colorValue: AppColors.black.value
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.lGrey.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: buildRowWithTwoOptions(title1: "العنوان الوطني:",
              value1: contractModel.lessorAddress ?? "",
              title2: "",
              value2: '',
              colorValue: AppColors.black.value
          ),
        ),
        // Container(
        //   width: double.infinity,
        //   height: 50,
        //   color: PdfColor.fromInt(AppColors.darkGreen.value),
        //   padding:
        //   const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        //   alignment: Alignment.center,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       PdfText("بيانات ممثل المؤجر",
        //           font: font, color: AppColors.white.value, size: 15),
        //       PdfText("Lessor Representative Data",
        //           font: font, color: AppColors.white.value, size: 15),
        //     ],
        //   ),
        // ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.darkGreen.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PdfText("بيانات المستأجر",
                  font: font, color: AppColors.white.value, size: 15),
              PdfText("Tenant Data",
                  font: font, color: AppColors.white.value, size: 15),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.white.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: buildRowWithTwoOptions(title1: "الاسم:",
              value1: contractModel.tenantFullName ?? "",
              title2: "الجنسية:",
              value2: contractModel.tenantNationality ?? '',
              colorValue: AppColors.black.value
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.lGrey.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: buildRowWithTwoOptions(title1: "نوع الهوية:",
              value1: contractModel.tenantIdentityType ?? "",
              title2: "رقم الهوية:",
              value2: contractModel.tenantIdentityNum ?? '',
              colorValue: AppColors.black.value
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.white.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: buildRowWithTwoOptions(title1: "رقم الجوال:",
              value1: contractModel.tenantPhone ?? "",
              title2: "",
              value2: '',
              colorValue: AppColors.black.value
          ),
        ),



      ],
    );
  }

  Row buildRowWithTwoOptions({required String title1,required String value1,
  required String title2,required String value2,required int colorValue}) {
    return Row(children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PdfText(title1,
                      font: font, color: AppColors.black.value, size: 15),
                  PdfText(value1,
                      font: font, color: AppColors.black.value, size: 15),
                ],
              )),
              SizedBox(width: 20.h),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PdfText(title2,
                      font: font, color: colorValue, size: 15),
                  PdfText(value2,
                      font: font, color: colorValue, size: 15),
                ],
              )),
            ]);
  }
}

class PdfTableCell extends StatelessWidget {
  final Widget child;

  PdfTableCell({
    required this.child,
  });

  @override
  Widget build(Context context) {
    return SizedBox(
      width: 70,
      child: child,
    );
  }
}

class PdfText extends StatelessWidget {
  final String text;
  final Font font;
  final int? color;
  final double? size;

  PdfText(
    this.text, {
    required this.font,
    this.color,
    this.size,
  });

  @override
  Widget build(Context context) {
    return Text(
      text,
      style: TextStyle(
        font: font,
        fontSize: size,
        color: PdfColor.fromInt(color ?? AppColors.black.value),
      ),
      textDirection: TextDirection.rtl,
    );
  }
}

class RowWithIcon extends StatelessWidget {
  final String title;
  final int icon;
  final int color;
  final Font font;
  final Font iconFont;

  RowWithIcon({
    required this.title,
    required this.icon,
    required this.color,
    required this.font,
    required this.iconFont,
  });

  @override
  Widget build(Context context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            font: font,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: PdfColor.fromInt(color),
          ),
          textDirection: TextDirection.rtl,
        ),
        SizedBox(width: 10.0),
        Icon(
          IconData(
            icon,
          ),
          size: 10,
          font: iconFont,
          color: PdfColor.fromInt(color),
        ),
      ],
    );
  }
}

class ColumnTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Font font;

  ColumnTile({
    required this.title,
    required this.subtitle,
    required this.font,
  });

  @override
  Widget build(Context context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PdfText(
          title,
          font: font,
          color: AppColors.black2.value,
        ),
        SizedBox(height: 5.0),
        PdfText(
          subtitle,
          font: font, //21 bold
          color: AppColors.softAsh.value,
        ),
      ],
    );
  }
}

/*
location_city e7f1
arrow_circle_left eaa7
call e0b0
location_on e0c8
file_copy e173
 */
