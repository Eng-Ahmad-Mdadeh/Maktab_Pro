import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:maktab_lessor/presentation/resources/app_colors.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_switch.dart';

import '../../../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../../../../data/models/contract/contract_model_model.dart';
import '../../../../../../../../../../domain/contract_models/contract_models_bloc.dart';
import '../../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import '../../../../../../../../../../domain/contracts/contract/add/contract_state.dart';
import '../../../../../../../../../widgets/maktab_drop_down_form_field.dart';
import '../../../../../../../../../widgets/body_text.dart';
import '../../../../../../../../../widgets/section_title.dart';

class ContractStep4 extends StatelessWidget {
  const ContractStep4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 37.0.v, right: 20.0.h, left: 20.0.h, bottom: 25.0.v),
      child: Form(
        key: context.read<ContractCubit>().step4Key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SectionTitle(title: 'يجب موافقة الطرف الاخر؟'),
                  BlocBuilder<ContractCubit, ContractEntity>(
                    builder: (context, state) {
                      return MaktabSwitch(
                        value: state.mustAccept ?? false,
                        onChanged: context.read<ContractCubit>().setmustAccept,
                      );
                    },
                  ),
                ],
              ),
              BlocBuilder<ContractModelsBloc, ContractModelsState>(
                builder: (context, state) {
                  if (state is ContractModelsSuccess) {
                    return ContractModelSelectWidget(
                      title: "اختر نموذج العقد",
                      items: state.contractModels,
                      onChanged: context.read<ContractCubit>().setcontractContent,
                      onClear: context.read<ContractCubit>().clearContractContent,
                      req: false,
                    );
                  }
                  return ContractModelSelectWidget(
                    title: "اختر نموذج العقد",
                    items: const [],
                    onChanged: (v) {},
                  );
                },
              ),
              ContractHtmlEditorWidget(
                context.read<ContractCubit>().quillController,
                title: "محتوى العقد",
                disabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContractHtmlEditorWidget extends StatelessWidget {
  final String title;
  final String? initText;
  final String? hint;
  final bool disabled;
  final ToolbarType? toolbarType;
  final double? height;
  final QuillController _quillController;

  const ContractHtmlEditorWidget(
    this._quillController, {
    super.key,
    required this.title,
    this.disabled = false,
    this.initText,
    this.hint,
    this.toolbarType,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyText(
          text: title,
        ),
        QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            controller: _quillController,
            showClipboardCopy: false,
            showClipboardPaste: false,
            showClipboardCut: false,
            showSearchButton: false,
            showCodeBlock: false,
            showInlineCode: false,
            showLink: false,
            showIndent: false,
            showHeaderStyle: false,
            showSubscript: false,
            showSuperscript: false,
            showDividers: false,
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('ar'),
            ),
          ),
        ),
        QuillEditor.basic(
          configurations: QuillEditorConfigurations(
            minHeight: 450.0.v,
            controller: _quillController,
          ),
        ),
      ],
    );
  }
}

class ContractModelSelectWidget extends StatelessWidget {
  final String title;
  final List<ContractModelModel> items;
  final void Function(ContractModelModel?) onChanged;
  final bool req;
  final Function()? onClear;

  const ContractModelSelectWidget({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.req = true,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0.v),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyText(
            text: title,
            fontSize: 15.0,
          ),
          Row(
            children: [
              Expanded(
                child: MaktabDropDownFormField(
                  items: items.map((e) => e.name!).toList(),
                  idItems: items.map((e) => e.id.toString()).toList(),
                  onChanged: (id) => onChanged(items.firstWhere((e) => e.id.toString() == id)),
                  validator: req
                      ? (value) {
                          if ((value ?? '').isEmpty) {
                            return 'هذا القسم اجباري';
                          }
                          return null;
                        }
                      : null,
                ),
              ),
              IconButton(
                onPressed: onClear,
                color: AppColors.black,
                icon: const Icon(Icons.clear),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
