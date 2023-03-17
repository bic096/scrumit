import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrumit/core/presentaion/text_style.dart';
import 'package:scrumit/features/projects/presentation/controllers/project_controller.dart';
import 'package:scrumit/features/projects/presentation/controllers/release_backlog_controller.dart';
import 'package:scrumit/features/projects/presentation/widgets/main_app_button_widget.dart';
import 'package:scrumit/core/presentaion/editable_text_widget.dart' as editable;

class ReleaseBacklogScreen extends StatelessWidget {
  ReleaseBacklogScreen({super.key, this.title});
  final String? title;
  final rblCtrl = Get.find<ReleaseBacklogController>();
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
                      editable.EditableText(
                        onChanged: (value) {
                          rblCtrl.releaseCopyWith(name: value);
                          debugPrint(rblCtrl.releaseBacklog.value.toString());
                        },
                        formGlobalKey: _formKey,
                        onsubmit: (String value) {
                          rblCtrl.releaseCopyWith(name: value);
                          debugPrint(rblCtrl.releaseBacklog.value.toString());
                        },
                        onEditingComplete: () {
                          _formKey.currentState?.save();
                        },
                        onSaved: (var newValue) {
                          rblCtrl.releaseCopyWith(name: newValue);
                          debugPrint(rblCtrl.releaseBacklog.value.toString());
                        },
                        data: rblCtrl.releaseBacklog.value.name,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'discription',
                        style: CustomTextStyle.buttonTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      editable.EditableText(
                        onChanged: (value) {
                          rblCtrl.releaseCopyWith(description: value);
                          debugPrint(rblCtrl.releaseBacklog.value.toString());
                        },
                        formGlobalKey: _formKey,
                        onsubmit: (value) {
                          rblCtrl.releaseCopyWith(description: value);
                          debugPrint(rblCtrl.releaseBacklog.value.toString());
                        },
                        onSaved: (var newValue) {
                          rblCtrl.releaseCopyWith(description: newValue);
                          debugPrint(rblCtrl.releaseBacklog.value.toString());
                        },
                        data: rblCtrl.releaseBacklog.value.description,
                        onEditingComplete: () {
                          _formKey.currentState?.save();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'priority',
                        style: CustomTextStyle.buttonTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      editable.EditableText(
                        onChanged: (value) {
                          rblCtrl.releaseCopyWith(priority: value);
                          debugPrint(rblCtrl.releaseBacklog.value.toString());
                        },
                        formGlobalKey: _formKey,
                        onsubmit: (value) {
                          rblCtrl.releaseCopyWith(priority: value);
                          debugPrint(rblCtrl.releaseBacklog.value.toString());
                        },
                        onSaved: (var newValue) {
                          rblCtrl.releaseCopyWith(priority: newValue);
                          debugPrint(rblCtrl.releaseBacklog.value.toString());
                        },
                        data: rblCtrl.releaseBacklog.value.priority,
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
                  debugPrint(_formKey.currentState.toString());
                  if (title == 'add release backlog') {
                    await rblCtrl
                        .addReleaseBacklog(rblCtrl.releaseBacklog.value);
                  }
                  if (title == rblCtrl.releaseBacklog.value.name) {
                    await rblCtrl.updateReleaseBacklogFun(
                        rblCtrl.releaseBacklog.value,
                        rblCtrl.releaseBacklog.value.id);
                  }
                  Get.back();
                  rblCtrl.listReleaseBacklogs(pCtrl.currentProjectId);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
//first release baccklog from phone
//first release backlog from phone description

// classeditable. EditableText extends StatefulWidget {
//   consteditable. EditableText(
//       {super.key,
//       required this.data,
//       required this.formGlobalKey,
//       required this.onsubmit,
//       required this.onEditingComplete,
//       required this.onSaved,
//       required this.onChanged});
//   final String data;
//   final GlobalKey formGlobalKey;
//   final Function onsubmit;
//   final Function onEditingComplete;
//   final Function onSaved;
//   final Function onChanged;

//   @override
//   Stateeditable.<EditableText> createState() => _EditableTextState();
// }

// class _EditableTextState extends Stateeditable.<EditableText> {
//   bool isEditable = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 10),
//       child: Row(children: [
//         Expanded(
//             child: GestureDetector(
//                 onTap: () {
//                   isEditable = !isEditable;
//                   setState(() {});
//                 },
//                 onDoubleTap: () {
//                   isEditable = !isEditable;
//                   setState(() {});
//                 },
//                 child: !isEditable
//                     ? Text(widget.data)
//                     : TextFormField(
//                         initialValue: widget.data,
//                         textInputAction: TextInputAction.done,
//                         onFieldSubmitted: (value) => widget.onsubmit(value),
//                         onEditingComplete: () => widget.onEditingComplete(),
//                         onSaved: (newValue) => widget.onSaved(newValue),
//                         onChanged: (value) => widget.onChanged(value),
//                         maxLines: 5,
//                         minLines: 1,
//                       ))),
//         // IconButton(
//         //   icon: Icon(Icons.edit),
//         //   onPressed: () {
//         //     setState(() => {
//         //           isEditable = !isEditable,
//         //         });
//         //   },
//         // )
//       ]),
//     );
//   }
// }
