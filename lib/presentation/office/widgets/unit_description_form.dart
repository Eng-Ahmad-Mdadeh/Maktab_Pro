import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/resources/app_colors.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitDescriptionForm extends StatefulWidget {
  const UnitDescriptionForm({super.key});

  @override
  State<UnitDescriptionForm> createState() => _UnitDescriptionFormState();
}

class _UnitDescriptionFormState extends State<UnitDescriptionForm> {
  late TextEditingController _unitDescriptionController;
  late GlobalKey<FormState> _unitDescriptionFormKey;

  @override
  void initState() {
    UnitState state = context.read<UnitBloc>().state;
    _unitDescriptionController = TextEditingController(text: state.description);
    _unitDescriptionFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionTitle(title: 'اكتب وصف مميز لمكتبك *'),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(title: 'وصف مميز لمكتبك'),
                          SizedBox(height: 10.v),
                          SelectableText(
                            'تقع في شمال الرياض مطلة على بوليفارد الرياض قريبة من شارع تركي الأول. صُممت بألوان مريحة مؤثثة بأثاث مودرن. يوجد شاشة 85 بوصة واشتراك بين سبورت لمتابعة المباريات. تتميز بمساحتها الواسعة وخصوصية تامة بدخول ذكي. أتمنى لك إقامة سعيدة و حياك الله ضيفي.',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: AppColors.slateGray,
                                ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text(
                'مثال',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.emeraldTeal,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.v),
        Form(
          key: _unitDescriptionFormKey,
          child: MaktabTextFormField(
            controller: _unitDescriptionController,
            minLines: 7,
            maxLines: null,
            validator: (value) {
              if (value!.isEmpty) {
                return 'الوصف مطلوب';
              } else if (value.trim().length < 8) {
                return 'الوصف يجب على الاقل ان يكون 8 محارف';
              }
              return null;
            },
            onChanged: (value) {
              context.read<UnitBloc>().add(SetDescriptionEvent(value!.trim()));
            },
          ),
        ),
      ],
    );
  }
}
