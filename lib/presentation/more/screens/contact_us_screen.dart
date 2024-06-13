import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_button.dart';
import 'package:maktab/presentation/widgets/page_title.dart';
import 'package:maktab/presentation/widgets/section_title.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/maktab_app_bar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(title: 'تواصل معنا'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 25.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.faceSmileWink,
                    color: AppColors.lightCyan,
                    size: 50,
                  ),
                  SizedBox(width: 15.h),
                  const PageTitle(title: 'نخدمك بعيوننا'),
                ],
              ),
              SizedBox(height: 30.v),
              const BodyText(
                text:
                    'من هذي الصفحة بامكانك التواصل مع مدير حسابك طوال أيام الاسبوع من الساعة 09:30 صباحا وحتى الساعة 09:00 مساء',
                fontSize: 17.0,
              ),
              SizedBox(height: 25.v),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle(
                    title: 'تواصل عن طريق',
                    fontSize: 17.0,
                  ),
                  SizedBox(height: 15.v),
                  SizedBox(
                    height: 50.v,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaktabButton(
                          width: 150.h,
                          backgroundColor: AppColors.lightCyan,
                          color: AppColors.white,
                          padding: EdgeInsets.zero,
                          fontSize: 17.0,
                          text: 'الايميل',
                          onPressed: () async {
                            await launchUrl(Uri.parse('mailto:info@Aqartik.sa'));
                          },
                        ),
                        MaktabButton(
                          width: 160.h,
                          padding: EdgeInsets.zero,
                          backgroundColor: AppColors.lightCyan,
                          color: AppColors.white,
                          fontSize: 17.0,
                          text: 'مركز الاتصال',
                          onPressed: () async {
                            await launchUrl(Uri.parse('tel://+966512345678'));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
