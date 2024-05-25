import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/offices/offices_cubit.dart';
import 'package:maktab/domain/unit/unit_bloc.dart';
import 'package:maktab/presentation/office/widgets/office_category_box.dart';
import 'package:maktab/presentation/widgets/body_text.dart';
import 'package:maktab/presentation/widgets/maktab_text_form_field.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class UnitInfoStepStep extends StatefulWidget {
  const UnitInfoStepStep({super.key});

  @override
  State<UnitInfoStepStep> createState() => _UnitInfoStepState();
}

class _UnitInfoStepState extends State<UnitInfoStepStep> {
  late TextEditingController _unitNameController;
  late GlobalKey<FormState> _unitNameFormKey;

  @override
  void initState() {
    UnitState state = context.read<UnitBloc>().state;
    _unitNameController = TextEditingController(text: state.name);
    _unitNameFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: _unitNameFormKey,
            child: MaktabTextFormField(
              controller: _unitNameController,
              title: 'اسم الوحدة*',
              hintText: 'أدخل اسم وحدتك الذي سيظهر للضيوف',
              textInputType: TextInputType.name,
              validator: (value) {
                if (value!.trim().isEmpty) {
                  return 'الرجاء ادخال اسم الوحدة';
                } else if (value.trim().length < 4) {
                  return 'الاسم يجب على الاقل ان يكون مؤلف من 4 محارف';
                }
                return null;
              },
              onChanged: (value) {
                context.read<UnitBloc>().add(SetUnitNameEvent(value!.trim()));
              },
            ),
          ),
          SizedBox(height: 20.v),
          const SectionTitle(title: 'تصنيف مكتبك'),
          SizedBox(height: 10.v),
          const BodyText(text: 'حدد التصميم المناسب'),
          SizedBox(height: 15.v),
          BlocBuilder<UnitBloc, UnitState>(
            builder: (context, state) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10.v,
                  crossAxisSpacing: 8.h,
                ),
                itemCount: context
                    .read<OfficesCubit>()
                    .state
                    .searchData!
                    .officeCategories
                    .length,
                itemBuilder: (context, index) {
                  return OfficeCategoryBox(
                    officeCategory: context
                        .read<OfficesCubit>()
                        .state
                        .searchData!
                        .officeCategories[index],
                    isSelected: context.read<UnitBloc>().state.categoryId ==
                        context
                            .read<OfficesCubit>()
                            .state
                            .searchData!
                            .officeCategories[index]
                            .id,
                    onTap: () {
                      context.read<UnitBloc>().add(SelectCategoryEvent(context
                          .read<OfficesCubit>()
                          .state
                          .searchData!
                          .officeCategories[index]
                          .id));
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
