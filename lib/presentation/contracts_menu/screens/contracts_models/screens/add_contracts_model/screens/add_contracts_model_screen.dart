import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:maktab_lessor/core/helpers/size_helper.dart';
import 'package:maktab_lessor/presentation/contracts_menu/screens/contracts/screens/contract/screens/add/widgets/contract_select_widget.dart';
import 'package:maktab_lessor/presentation/contracts_menu/screens/contracts/screens/contract/screens/add/widgets/step4/contract_step4.dart';
import 'package:maktab_lessor/presentation/widgets/loading_dialog.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_button.dart';
import 'package:maktab_lessor/presentation/widgets/maktab_snack_bar.dart';

import '../../../../../../../domain/contract_models/contract_model/contract_model_bloc.dart';
import '../../../../../../../domain/contract_models/contract_models_bloc.dart';
import '../../../../../../widgets/maktab_app_bar.dart';
import '../../../../contracts/screens/contract/screens/add/widgets/contract_input_widget.dart';

class AddContractsModelScreen extends StatelessWidget {
  AddContractsModelScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final QuillController _quillController = QuillController(
    selection: TextSelection.fromPosition(const TextPosition(offset: 0)),
    document: Document(),
  );
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContractModelBloc, ContractModelState>(
      listener: (context, state) {
        if (state is ContractModelLoading) {
          LoadingDialog.show(context);
        }
        if (state is ContractModelFailure) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showError(context, state.message);
        }
        if (state is ContractModelSuccess) {
          LoadingDialog.hide(context);
          MaktabSnackbar.showSuccess(context, "تم الحفظ بنجاح");
          context.pop();
          context.read<ContractModelsBloc>().add(GetContractsModels());
        }
      },
      child: Scaffold(
        appBar: const MaktabAppBar(
          title: 'نموذج عقد جديد',
        ),
        body: Padding(
          padding: EdgeInsets.all(14.0.adaptSize),
          child: SingleChildScrollView(
            child: Form(
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
                          validator: (value){
                            if((value??'').isEmpty){
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
                          validator: (value){
                            if((value??'').isEmpty){
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
                    value: '1',
                    children: const ['فعال', 'غير فعال'],
                    onChanged: (value) {
                      _statusController.text = value ?? '';
                    },
                  ),
                  ContractHtmlEditorWidget(
                    _quillController,
                    title: "محتوى النموذج",
                    hint: "محتوى النموذج",
                    toolbarType: ToolbarType.nativeExpandable,
                    height: 600,
                  ),
                  MaktabButton(
                    text: "حفظ",
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        final String editorText = _quillController.document.toPlainText();
                        context.read<ContractModelBloc>().add(CreateContractModels(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          contentContractModel: editorText,
                          status: _statusController.text == '1' ? '1' : _statusController.text == '0' ? '0' : '1',
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
