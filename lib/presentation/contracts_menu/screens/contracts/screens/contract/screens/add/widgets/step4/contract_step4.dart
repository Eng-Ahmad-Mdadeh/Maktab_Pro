import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:maktab/presentation/resources/app_colors.dart';

import '../../../../../../../../../../../core/helpers/size_helper.dart';
import '../../../../../../../../../../data/models/contract/contract_model_model.dart';
import '../../../../../../../../../../domain/contract_models/contract_models_bloc.dart';
import '../../../../../../../../../../domain/contracts/contract/add/contract_cubit.dart';
import '../../../../../../../../../widgets/maktab_drop_down_form_field.dart';
import '../../../../../../../../../widgets/body_text.dart';

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
                context.read<ContractCubit>().htmlEditorController,
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
  final String? hint;
  final HtmlEditorController _controller;
  final bool disabled;
  final ToolbarType? toolbarType;
  final double? height;

  const ContractHtmlEditorWidget(
    this._controller, {
    super.key,
    required this.title,
    this.disabled = false,
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
        HtmlEditor(
          controller: _controller,
          htmlEditorOptions: HtmlEditorOptions(
            hint: hint,
            shouldEnsureVisible: true,
            darkMode: false,
            disabled: disabled,
            //initialText: "<p>text content initial, if any</p>",
          ),
          htmlToolbarOptions: HtmlToolbarOptions(
            toolbarPosition: ToolbarPosition.aboveEditor,
            //by default
            toolbarType: toolbarType ?? ToolbarType.nativeScrollable,
            dropdownFocusColor: AppColors.black,
            dropdownIconColor: AppColors.black,
            buttonBorderColor: AppColors.black,
            buttonColor: AppColors.black,
            buttonFillColor: AppColors.black,
            buttonFocusColor: AppColors.black,
            buttonHighlightColor: AppColors.black,
            buttonHoverColor: AppColors.black,
            buttonSelectedBorderColor: AppColors.black,
            buttonSelectedColor: AppColors.black,
            buttonSplashColor: AppColors.black,
            dropdownBackgroundColor: AppColors.white,
            //by default
            onButtonPressed: (ButtonType type, bool? status, Function? updateStatus) {
              log("button '$type' pressed, the current selected status is $status");
              return true;
            },
            onDropdownChanged: (DropdownType type, dynamic changed, Function(dynamic)? updateSelectedItem) {
              log("dropdown '$type' changed to $changed");
              return true;
            },
            mediaLinkInsertInterceptor: (String url, InsertFileType type) {
              log(url);
              return true;
            },
            mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
              log(file.name); //filename
              log(file.size.toString()); //size in bytes
              log(file.extension.toString()); //file extension (eg jpeg or mp4)
              return true;
            },
          ),
          otherOptions: OtherOptions(
            height: height?.v ?? 450.0.v,
          ),
          plugins: [
            SummernoteAtMention(
              getSuggestionsMobile: (String value) {
                var mentions = <String>['test1', 'test2', 'test3'];
                return mentions.where((element) => element.contains(value)).toList();
              },
              mentionsWeb: ['test1', 'test2', 'test3'],
              onSelect: (String value) {
                log(value);
              },
            ),
          ],
          callbacks: Callbacks(
            onInit: () {
              _controller.editorController!.evaluateJavascript(
                source: "\$('div.note-editable').attr('dir', 'rtl');",
              );
            },
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
