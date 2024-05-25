import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/domain/profile/profile_bloc.dart';
import 'package:maktab/presentation/profile/widgets/account_type_option.dart';
import 'package:maktab/presentation/widgets/retry_button.dart';
import 'package:maktab/presentation/widgets/section_title.dart';

class AccountTypeOptions extends StatefulWidget {
  const AccountTypeOptions({super.key});

  @override
  State<AccountTypeOptions> createState() => _AccountTypeOptionsState();
}

class _AccountTypeOptionsState extends State<AccountTypeOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'نوع الحساب'),
        SizedBox(height: 25.v),
        SizedBox(
            height: 140.v,
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state.fetchingUserTypes == FetchUserTypes.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.fetchingUserTypes == FetchUserTypes.failure) {
                  return Center(
                    child: RetryButton(
                      onTap: () {
                        context.read<ProfileBloc>().add(GetUserTypes());
                      },
                    ),
                  );
                }
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.h,
                        mainAxisSpacing: 10.v,
                        childAspectRatio: 2.3),
                    itemCount:
                        state.userTypes != null ? state.userTypes!.length : 0,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AccountTypeOption(
                        title: state.userTypes![index].arName,
                        isSelected: state.selectedAccountTypeIndex ==
                            state.userTypes![index].id,
                        onTap: () {
                          context.read<ProfileBloc>().add(
                              SelectAccountTypeEvent(
                                  index: state.userTypes![index].id));
                        },
                      );
                    });
              },
            )),
      ],
    );
  }
}
