import 'package:maktab_lessor/core/extension/date_time_extension.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';

import '../../../../../../data/models/invoice/invoice_model.dart';
import '../../resources/app_colors.dart';

class InvoicePrintScreen extends StatelessWidget {
  final Invoice invoice;
  final Font font;
  final Font materialFont;
  final ImageProvider logo;

  InvoicePrintScreen(
    this.invoice, {
    required this.font,
    required this.materialFont,
    required this.logo,
  });

  @override
  Widget build(Context context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(logo, width: 100, height: 100),
            PdfText(
              (invoice.invoiceStatus == 'paid'
                  ? 'مسددة'
                  : invoice.invoiceStatus == 'partial'
                      ? 'مسدد جزئيا'
                      : invoice.invoiceStatus.toString()),
              font: font,
              size: 15,
              color: (invoice.invoiceStatus == 'paid'
                  ? AppColors.mintGreen.value
                  : invoice.invoiceStatus == 'partial'
                      ? AppColors.cherryRed.value
                      : AppColors.black.value),
            ),
            PdfText(
              "INVOICE",
              font: font,
              size: 17,
            ),
          ],
        ),
        PdfText(
          "Invoice no: ${invoice.invoiceNumber}",
          font: font,
          // style: TextStyle(font: font, fontSize: 30, fontWeight: FontWeight.bold, color: black),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RowWithIcon(
              title: "مؤسسة مكتبك الذكي",
              icon: 0xe7f1,
              color: AppColors.black.value,
              font: font,
              iconFont: materialFont,
            ),
            RowWithIcon(
              title: "رقم السجل التجاري: ${invoice.admin?.registerNumber}",
              icon: 0xeaa7,
              color: AppColors.black.value,
              font: font,
              iconFont: materialFont,
            ),
            RowWithIcon(
              title: "رقم الجوال: ${invoice.admin?.mobileNumber}",
              icon: 0xe0b0,
              color: AppColors.black.value,
              font: font,
              iconFont: materialFont,
            ),
            RowWithIcon(
              title: "العنوان: ${invoice.admin?.city}, ${invoice.admin?.neighborhood}, ${invoice.admin?.street}, ${invoice.admin?.buildingNumber}",
              icon: 0xe0c8,
              color: AppColors.black.value,
              font: font,
              iconFont: materialFont,
            ),
            RowWithIcon(
              title: "الرقم الضريبي: ${invoice.admin?.taxNumber}",
              icon: 0xe173,
              color: AppColors.black.value,
              font: font,
              iconFont: materialFont,
            ),
          ],
        ),
        SizedBox(height: 30.0),
        Container(
          width: double.infinity,
          height: 50,
          color: PdfColor.fromInt(AppColors.mintGreen.value),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ColumnTile(
                title: "رقم الجوال",
                subtitle: invoice.lessor?.phone ?? '',
                font: font,
              ),
              ColumnTile(
                title: 'طريقة السداد للعميل',
                subtitle: invoice.paymentMethod == 'Stc' ? 'Stc pay' : (invoice.paymentMethod ?? ''),
                font: font,
              ),
              ColumnTile(
                title: "اسم العميل",
                subtitle: invoice.lessor?.username ?? '',
                font: font,
              ),
              ColumnTile(
                title: "التاريخ",
                subtitle: invoice.releaseDate?.dayFormatWithLocale('ar') ?? '',
                font: font,
              ),
            ],
          ),
        ),
        SizedBox(height: 30.0),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: PdfColor.fromInt(AppColors.mintGreen.value),
                  border: Border.all(color: PdfColor.fromInt(AppColors.mintGreen.value)),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PdfTableCell(child: PdfText("المبلغ المتبقي", font: font, color: AppColors.white.value)),
                    PdfTableCell(child: PdfText("المبلغ المدفوع", font: font, color: AppColors.white.value)),
                    PdfTableCell(child: PdfText("الوصف", font: font, color: AppColors.white.value)),
                    // PdfTableCell(child: PdfText("السعر", font: font, color: AppColors.white.value)),
                    // PdfTableCell(child: PdfText("الوصف", font: font, color: AppColors.white.value)),
                    // PdfTableCell(child: PdfText("رقم الخدمة", font: font, color: AppColors.white.value)),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: PdfColor.fromInt(AppColors.mintGreen.value)),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PdfTableCell(child: PdfText(invoice.remainingAmount ?? '0', font: font)),
                    PdfTableCell(child: PdfText(invoice.paidAmount ?? '0', font: font)),
                    PdfTableCell(child: PdfText(invoice.description ?? '', font: font)),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PdfText(
                  "إجمالي المبلغ",
                  font: font,
                  size: 19,
                ),
                SizedBox(height: 5.0),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: PdfColor.fromInt(AppColors.mintGreen.value)),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: PdfText(
                    '${invoice.totalAmount ?? '0'} ريال',
                    font: font,
                    size: 19,
                    color: AppColors.white.value,
                  ),
                ),
              ],
            ),
            PdfText("ضريبة القيمة المضافة: ${invoice.taxValue ?? '0'} ريال", font: font),
          ],
        ),
      ],
    );
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
