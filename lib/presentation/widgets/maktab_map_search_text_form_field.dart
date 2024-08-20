import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/data/models/map/map_search_suggestion.dart';
import 'package:maktab_lessor/domain/map/map_cubit.dart';
import 'package:maktab_lessor/domain/office/office_bloc.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/body_text.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_text_form_field.dart';

class MaktabMapSearchTextField extends StatefulWidget {
  const MaktabMapSearchTextField({super.key});

  @override
  State<MaktabMapSearchTextField> createState() => _MaktabMapSearchTextFieldState();
}

class _MaktabMapSearchTextFieldState extends State<MaktabMapSearchTextField> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<MapSearchSuggestion>(
      controller: searchController,
      suggestionsCallback: (input) async => await context.read<MapCubit>().getSearchSuggestions(input),
      hideWithKeyboard: false,
      hideOnEmpty: true,
      builder: (context, controller, focusNode) {
        return MaktabTextFormField(
          controller: controller,
          focusNode: focusNode,
          hintText: 'أدخل عنوان للبحث',
        );
      },
      loadingBuilder: (context) {
        return Container(
          width: SizeHelper.width,
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.v),
          color: AppColors.white,
          child: const BodyText(text: 'جاري التحميل ...'),
        );
      },
      itemBuilder: (context, MapSearchSuggestion suggestion) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.v),
          color: AppColors.white,
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.slateGray,
              ),
              SizedBox(width: 10.h),
              Expanded(child: BodyText(text: suggestion.description)),
            ],
          ),
        );
      },
      emptyBuilder: (context) {
        return Container(
          width: SizeHelper.width,
          padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.v),
          color: AppColors.white,
          child: const BodyText(text: 'لا يوجد نتائج بحث'),
        );
      },
      onSelected: (suggestion) {
        context.read<OfficeBloc>().add(GoToSelectedAddressEvent(suggestion.placeId));
      },
    );
  }
}
