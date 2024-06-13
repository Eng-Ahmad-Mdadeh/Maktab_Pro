import 'package:maktab/core/helpers/size_helper.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';

import '../../../../../../../../data/models/contract/contract_model.dart';
import '../../../../../../../resources/app_colors.dart';



class ContractPrintThirdPageScreen extends StatelessWidget {
  final ContractModel contractModel;
  final Font font;
  final Font materialFont;
  final ImageProvider logo;

  ContractPrintThirdPageScreen(
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
              PdfText("البيانات المالَية",
                  font: font, color: AppColors.white.value, size: 15),
              PdfText("Financial Data",
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
          child: buildRowWithTwoOptions(title1: "قيمة التأمين(لا تدخل ضمن القيمة الاجمالية للعقد):",
              value1:contractModel.insuranceAmount??"",
              title2: "",
              value2: "",
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
          child: buildRowWithTwoOptions(title1: "قيمة العربون المدفوع:",
              value1:contractModel.downPayment??"",
              title2: " دورة سداد اإيجار:",
              value2:  contractModel.typeReservation??"",
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
          child: buildRowWithTwoOptions(title1: "إجمالي قيمة العقد",
              value1:contractModel.totalPrice??"",
              title2: "",
              value2: "",
              colorValue: AppColors.black.value
          ),
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
              PdfText("محتوى العقد",
                  font: font, color: AppColors.white.value, size: 15),
              PdfText("Contract Content",
                  font: font, color: AppColors.white.value, size: 15),
            ],
          ),


        ),
        SizedBox(height: 20.v),
        if(contractModel.contractContent!=''&&contractModel.contractContent!=null)
        PdfText(contractModel.contractContent.toString().replaceAll('<p>', ''),
            font: font, color: AppColors.black.value, size: 15),


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
          color: AppColors.black.value,
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
