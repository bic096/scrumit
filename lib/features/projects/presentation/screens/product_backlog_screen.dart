import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/core/presentaion/text_style.dart';
import 'package:scrumit/features/projects/presentation/controllers/product_backlog_controller.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/projects/presentation/widgets/main_app_button_widget.dart';

class ProductBacklogScreen extends StatelessWidget {
  ProductBacklogScreen({super.key, this.title});
  final String? title;
  final pblCtrl = Get.find<ProductBacklogController>();
  final pCtrl = Get.find<ProjectController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        title: title == null ? null : Text(title!),
      ),
      body: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Name',
                          style: CustomTextStyle.buttonTextStyle),
                      const SizedBox(
                        height: 10,
                      ),
                      EditableText(
                        onChanged: (value) {
                          pblCtrl.productCopyWith(name: value);
                          debugPrint(pblCtrl.productBacklog.value.toString());
                        },
                        formGlobalKey: _formKey,
                        onsubmit: (String value) {
                          pblCtrl.productCopyWith(name: value);
                          debugPrint(pblCtrl.productBacklog.value.toString());
                        },
                        onEditingComplete: () {
                          _formKey.currentState?.save();
                        },
                        data: pblCtrl.productBacklog.value.name,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('discription',
                          style: CustomTextStyle.buttonTextStyle),
                      const SizedBox(
                        height: 10,
                      ),
                      EditableText(
                        onChanged: (value) {
                          pblCtrl.productCopyWith(description: value);
                          debugPrint(pblCtrl.productBacklog.value.toString());
                        },
                        formGlobalKey: _formKey,
                        onsubmit: (value) {
                          pblCtrl.productCopyWith(description: value);
                          debugPrint(pblCtrl.productBacklog.value.toString());
                        },
                        data: pblCtrl.productBacklog.value.description,
                        onEditingComplete: () {
                          _formKey.currentState?.save();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('priority',
                          style: CustomTextStyle.buttonTextStyle),
                      const SizedBox(
                        height: 10,
                      ),
                      EditableText(
                        onChanged: (value) {
                          pblCtrl.productCopyWith(priority: value);
                          debugPrint(pblCtrl.productBacklog.value.toString());
                        },
                        formGlobalKey: _formKey,
                        onsubmit: (value) {
                          pblCtrl.productCopyWith(priority: value);
                          debugPrint(pblCtrl.productBacklog.value.toString());
                        },
                        data: pblCtrl.productBacklog.value.priority,
                        onEditingComplete: () {
                          _formKey.currentState?.save();
                        },
                      )
                    ]),
              ),
              MainAppButton(
                label: 'Submit',
                onPress: () async {
                  _formKey.currentState?.save();
                  if (title == 'add User Story') {
                    var backlog =
                        pblCtrl.productBacklog.value.copyWith(type: "story");
                    await pblCtrl.addProductBacklog(backlog);
                  }
                  if (title == pblCtrl.productBacklog.value.name) {
                    await pblCtrl.updateProductBacklogFun(
                        pblCtrl.productBacklog.value,
                        pblCtrl.productBacklog.value.id);
                  }

                  Get.back();
                  pblCtrl.listProductBacklogs(pCtrl.currentProjectId);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EditableText extends StatefulWidget {
  const EditableText(
      {super.key,
      required this.data,
      required this.formGlobalKey,
      required this.onsubmit,
      required this.onEditingComplete,
      required this.onChanged});
  final String data;
  final GlobalKey formGlobalKey;
  final Function onsubmit;
  final Function onEditingComplete;
  final Function onChanged;
  @override
  State<EditableText> createState() => _EditableTextState();
}

class _EditableTextState extends State<EditableText> {
  bool isEditable = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Row(children: [
        Expanded(
            child: GestureDetector(
                onDoubleTap: () {
                  isEditable = !isEditable;
                  setState(() {});
                },
                onTap: () {
                  isEditable = !isEditable;
                  setState(() {});
                },
                child: !isEditable
                    ? Text(widget.data)
                    : TextFormField(
                        initialValue: widget.data,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) => widget.onsubmit(value),
                        onEditingComplete: () => widget.onEditingComplete(),
                        onChanged: (value) => widget.onChanged(value),
                        maxLines: 5,
                        minLines: 1,
                      ))),
        // IconButton(
        //   icon: const Icon(Icons.edit),
        //   onPressed: () {
        //     setState(() => {
        //           isEditable = !isEditable,
        //         });
        //   },
        // )
      ]),
    );
  }
}
