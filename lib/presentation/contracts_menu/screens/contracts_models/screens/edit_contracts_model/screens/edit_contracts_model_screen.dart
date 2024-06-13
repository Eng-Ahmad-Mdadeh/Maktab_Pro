import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:maktab/core/helpers/size_helper.dart';
import 'package:maktab/presentation/widgets/loading_widget.dart';

import '../../../../../../../domain/contract_models/contract_model/contract_model_bloc.dart';
import '../../../../../../../domain/contract_models/contract_models_bloc.dart';
import '../../../../../../widgets/loading_dialog.dart';
import '../../../../../../widgets/maktab_app_bar.dart';
import '../../../../../../widgets/maktab_button.dart';
import '../../../../../../widgets/maktab_snack_bar.dart';
import '../../../../contracts/screens/contract/screens/add/widgets/contract_input_widget.dart';
import '../../../../contracts/screens/contract/screens/add/widgets/contract_select_widget.dart';
import '../../../../contracts/screens/contract/screens/add/widgets/step4/contract_step4.dart';

class EditContractsModelScreen extends StatefulWidget {
  const EditContractsModelScreen({super.key});

  @override
  State<EditContractsModelScreen> createState() => _EditContractsModelScreenState();
}

class _EditContractsModelScreenState extends State<EditContractsModelScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _statusController = TextEditingController();

  final HtmlEditorController _htmlController = HtmlEditorController();
  late final QuillController _quillController;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool canShowMessages = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MaktabAppBar(
        title: 'نموذج عقد جديد',
      ),
      body: Padding(
        padding: EdgeInsets.all(14.0.adaptSize),
        child: SingleChildScrollView(
          child: BlocConsumer<ContractModelBloc, ContractModelState>(
            listener: (context, state) {
              if (state is ContractModelLoading) {
                if (canShowMessages) {
                  LoadingDialog.show(context);
                }
              }
              if (state is ContractModelFailure) {
                if (canShowMessages) {
                  LoadingDialog.hide(context);
                  MaktabSnackbar.showError(context, "حدث خطأ");
                }
              }
              if (state is ContractModelSuccess) {
                _nameController.text = state.contractModel.name ?? '';
                _descriptionController.text = state.contractModel.description ?? '';
                log("LOADING TEXT INTO HTML");
                // _htmlController.setText(state.contractModel.contentContractModel ?? '');
                _quillController = QuillController(
                  document: Document.fromHtml(state.contractModel.contentContractModel??'<p></p>'),
                  selection: TextSelection.fromPosition(
                    const TextPosition(offset: 1),
                  ),
                );
                if (canShowMessages) {
                  LoadingDialog.hide(context);
                  MaktabSnackbar.showSuccess(context, "تم الحفظ بنجاح");
                  context.pop();
                  context.read<ContractModelsBloc>().add(GetContractsModels());
                }
              }
            },
            builder: (context, state) {
              return Form(
                key: _key,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ContractInputWidget(
                            title: "اسم النموذج",
                            onChanged: (value) {},
                            controller: _nameController,
                            validator: (value) {
                              if ((value ?? '').isEmpty) {
                                return 'لا يمكن تركه فارغا';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 7.0.h,
                        ),
                        Expanded(
                          child: ContractInputWidget(
                            title: "وصف النموذج",
                            onChanged: (value) {},
                            controller: _descriptionController,
                            validator: (value) {
                              if ((value ?? '').isEmpty) {
                                return 'لا يمكن تركه فارغا';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    ContractSelectWidget<String>(
                      title: 'اختر الحالة',
                      items: const ['1', '0'],
                      value: state is ContractModelSuccess ? state.contractModel.status ?? '1' : '1',
                      children: const ['فعال', 'غير فعال'],
                      onChanged: (value) {
                        _statusController.text = value ?? '';
                      },
                    ),
                    if (state is ContractModelSuccess)
                      ContractHtmlEditorWidget(
                        _htmlController,
                        _quillController,
                        initText: state.contractModel.contentContractModel,
                        title: "محتوى النموذج",
                        hint: "محتوى النموذج",
                        toolbarType: ToolbarType.nativeExpandable,
                        height: 600,
                      )else
                        const LoadingWidget(0),
                    MaktabButton(
                      text: "حفظ",
                      isLoading: state is ContractModelLoading,
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _htmlController.getText().then((value) {
                            if (state is ContractModelSuccess) {
                              context.read<ContractModelBloc>().add(EditContractModels(
                                    id: state.contractModel.id!,
                                    name: _nameController.text,
                                    description: _descriptionController.text,
                                    contentContractModel: value,
                                    status: _statusController.text.isEmpty
                                        ? (state.contractModel.status ?? '1')
                                        : _statusController.text,
                                  ));
                              canShowMessages = true;
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
