import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';

import '../../../../../../../../data/models/contract/contract_model.dart';
import '../../../../../../../resources/app_colors.dart';


class ContractPrintSecondPageScreen extends StatelessWidget {
  final ContractModel contractModel;
  final Font font;
  final Font materialFont;
  final ImageProvider logo;

  ContractPrintSecondPageScreen(
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
              PdfText("بيانات العقار",
                  font: font, color: AppColors.white.value, size: 15),
              PdfText("Property Data",
                  font: font, color: AppColors.white.value, size: 15),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.lGrey.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PdfText("العنوان الوطني",
                  font: font, color: AppColors.black.value, size: 15),
              PdfText('${contractModel.officeAddress},${contractModel.officeCity},${contractModel.officeBuildingNo}.',
                  font: font, color: AppColors.black.value, size: 15),

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
          child: buildRowWithTwoOptions(title1: "اسم العقار:",
              value1: contractModel.officeName ?? "",
              title2: "نوع بناء العقار:",
              value2: contractModel.officeTypeAqar ?? '',
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
          child: buildRowWithTwoOptions(title1: "الرمز البريدي:",
              value1: contractModel.officePostalCode ?? "",
              title2: " رقم المبنى: ",
              value2: contractModel.officeBuildingNo ?? '',
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
              PdfText("بيانات الوحدات الايجارَية",
                  font: font, color: AppColors.white.value, size: 15),
              PdfText("Data Units Rental",
                  font: font, color: AppColors.white.value, size: 15),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.lGrey.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: buildRowWithTwoOptions(title1: "نوع الوحدة: ",
              value1: contractModel.officeCategoryAqar ?? "",
              title2: "رقم الوحدة:",
              value2: contractModel.officeUnitNo ?? '',
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
          child: buildRowWithTwoOptions(title1: "رقم الطابق:",
              value1: contractModel.officeNoFloor ?? "",
              title2: "مساحة الوحدة:",
              value2: contractModel.officeSpace ?? '',
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
          child: buildRowWithTwoOptions(title1: "طول الواجهة المامية:",
              value1: contractModel.officeLengthFrontEnd ?? "",
              title2: "مشطّب:",
              value2: contractModel.officeIsMushtab ?? '',
              colorValue: AppColors.black.value
          ),
        ),
   if(contractModel.noWindowConditioners!='0')
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.white.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: buildRowWithTwoOptions(title1: "نوع التكييف:",
              value1:"شباك",
              title2: "العدد:",
              value2: contractModel.noWindowConditioners?? '',
              colorValue: AppColors.black.value
          ),
        ),
        if(contractModel.noCentralConditioners!='0')
          Container(
            width: double.infinity,
            height: 50,
            color: PdfColor.fromInt(AppColors.white.value),
            padding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
            alignment: Alignment.center,
            child: buildRowWithTwoOptions(title1: "نوع التكييف:",
                value1:"مركزي",
                title2: "العدد:",
                value2: contractModel.noCentralConditioners?? '',
                colorValue: AppColors.black.value
            ),
          ),
        if(contractModel.noSplitConditioners!='0')
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.white.value),
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: buildRowWithTwoOptions(title1: "نوع التكييف:",
              value1:"سبليت",
              title2: "العدد:",
              value2: contractModel.noSplitConditioners?? '',
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
          child: buildRowWithTwoOptions(title1: "الكهرباء:",
              value1:contractModel.electricityConstAmount!=null?'مبلغ ثابت':'حسب قراءة العداد',
              title2: " التكلفة :",
              value2: contractModel.electricityMoney??'-',
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
          child: buildRowWithTwoOptions(title1: "الماء:",
              value1:contractModel.waterConstAmount!=null?'مبلغ ثابت':'حسب قراءة العداد',
              title2: " التكلفة :",
              value2: contractModel.waterMoney?? '-',
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
