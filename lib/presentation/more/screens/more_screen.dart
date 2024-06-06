import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/shimmer/shimmer_bloc.dart';
import 'package:maktab/presentation/more/widgets/more_header.dart';
import 'package:maktab/presentation/more/widgets/more_items_list.dart';
import 'package:maktab/presentation/resources/app_assets.dart';
import 'package:maktab/presentation/widgets/maktab_image_view.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MoreHeader(),
              SizedBox(height: 20.v),
              const MoreItemsList(),
              SizedBox(
                height: 100.v,
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse('https://sta.sa/'));
                    },
                    child: MaktabImageView(
                      imagePath: AppAssets.logoStarsTech,
                      height: 40.v,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MaktabBottomAppBar(),
    );
  }
}
