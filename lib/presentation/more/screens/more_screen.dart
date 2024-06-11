import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab/presentation/more/widgets/more_header.dart';
import 'package:maktab/presentation/more/widgets/more_items_list.dart';
import 'package:maktab/presentation/resources/app_assets.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_image_view.dart';
import 'package:maktab/presentation/widgets/section_title.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/maktab_bottom_app_bar.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    context.read<ShimmerBloc>().add(BeginShimmerEffectEvent());
    _getAppVersion();
    super.initState();
  }
  String? version;
  _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MoreHeader(),
              SizedBox(height: 20.v),
              const MoreItemsList(),
              SizedBox(height: 50.0.v,),
              SectionTitle(title:  version != null ? "v${version!}" : "v0.0.1"),
              SizedBox(height: 30.0.v,),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BodyText(text: "Developed by"),
                  SizedBox(
                    height: 30.v,
                    child: InkWell(
                      onTap: () async {
                        await launchUrl(Uri.parse('https://sta.sa/'));
                      },
                      child: MaktabImageView(
                        imagePath: AppAssets.logoStarsTech,
                        height: 30.v,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MaktabBottomAppBar(),
    );
  }
}
