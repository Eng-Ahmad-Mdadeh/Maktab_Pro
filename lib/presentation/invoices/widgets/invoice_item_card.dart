import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maktab/core/extension/date_time_extension.dart';
import 'package:maktab/core/extension/string_extention.dart';
import 'package:maktab/data/repositories/settings_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../core/services/service_locator.dart';
import '../../../../../../data/models/invoice/invoice_model.dart';
import '../../../../../../core/helpers/size_helper.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../data/repositories/invoice_repository.dart';
import '../../resources/app_colors.dart';
import '../../widgets/body_text.dart';
import '../../widgets/section_title.dart';
import '../screens/invoice_print_screen.dart';

class InvoiceItemCard extends StatelessWidget {
  final Invoice invoice;

  const InvoiceItemCard({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          ListTile(
            leading: const SizedBox(),
            title: Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 5),
              child: SectionTitle(
                title: '${"المدفوع"}: ${invoice.paidAmount?.toStringAsNumber('ar')}',
                textAlign: TextAlign.start,
                fontSize: 16.0,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 15.0, right: 5),
              child: BodyText(
                text:'${"الباقي"}: ${invoice.remainingAmount?.toStringAsNumber('ar')}',
                textColor: invoice.remainingAmount == '0' ? AppColors.rustOrange : AppColors.black,
              ),
            ),
            trailing: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    // color: invoice.invoiceStatus == 'paid' ? AppColors.mintGreen : AppColors.coralPink,
                    borderRadius: BorderRadius.circular(7.0.adaptSize),
                  ),
                  padding: EdgeInsets.only(top: 7.0.adaptSize, left: 7.0.adaptSize, right: 7.0.adaptSize),
                  child: SectionTitle(
                    title: invoice.invoiceStatus == 'paid'
                        ? "مسدد"
                        : invoice.invoiceStatus == 'partial'
                            ? 'مسدد جزئي'
                            : '',
                    textColor:
                        invoice.invoiceStatus == 'paid' ? AppColors.deepForestGreen : AppColors.coralPink,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(
                  height: 3.0,
                ),
                BodyText(
                 text: invoice.createdAt!.dayFormatWithLocale('ar'),
                  textColor: AppColors.black,
                  fontSize: 13.0,
                ),
              ],
            ),
          ),
          Container(
            width: 55,
            height: 100,
            decoration: BoxDecoration(
              // color: invoice.invoiceStatus == 'paid' ? AppColors.mintGreen : AppColors.coralPink,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(10),
              ),
              gradient: invoice.invoiceStatus == 'paid'
                  ? const LinearGradient(
                      colors: [
                        AppColors.lushGreen,
                        AppColors.mintGreen,
                      ],
                    )
                  : const LinearGradient(
                      colors: [
                        AppColors.cherryRed,
                        AppColors.coralPink,
                      ],
                    ),
            ),
            child: Align(
              alignment: const Alignment(0, .6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SectionTitle(
                    title: '#${invoice.invoiceNumber}',
                    textColor: AppColors.white,
                  ),
                  InkWell(
                    onTap: () async {
                      final fullInvoice = await locator<InvoiceRepository>().getInvoice(invoice.id);

                      fullInvoice.fold(
                        (l) {},
                        (r) async {
                          final pdf = pw.Document();
                          final font = await PdfGoogleFonts.tajawalMedium();
                          final materialFont = await PdfGoogleFonts.materialIcons();
                          final generalSettings = await locator<SettingsRepository>().getGeneralSettings();
                          var logoURL = '';
                          generalSettings.fold((l) {}, (r) => logoURL = r.logo ?? '');

                          final logo = await networkImage(ApiEndpoints.siteUrl + logoURL);

                          pdf.addPage(
                            pw.Page(
                              build: (pw.Context context) => InvoicePrintScreen(
                                r,
                                font: font,
                                materialFont: materialFont,
                                logo: logo,
                              ),
                            ),
                          );
                          final path = await getDownloadsDirectory();

                          final file =
                              File('${path?.path}/invoice ${invoice.releaseDate?.toIso8601String()}.pdf');

                          await file.writeAsBytes(await pdf.save());
                          Share.shareXFiles([XFile(file.path)]);
                          // await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
                        },
                      );
                    },
                    child: const Icon(
                      Icons.cloud_download,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
