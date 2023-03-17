import 'package:flutter/material.dart';

class EditableText extends StatefulWidget {
  const EditableText(
      {super.key,
      required this.data,
      required this.formGlobalKey,
      required this.onsubmit,
      required this.onEditingComplete,
      required this.onSaved,
      required this.onChanged});
  final String data;
  final GlobalKey formGlobalKey;
  final Function onsubmit;
  final Function onEditingComplete;
  final Function onSaved;
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
                onTap: () {
                  isEditable = !isEditable;
                  setState(() {});
                },
                onDoubleTap: () {
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
                        onSaved: (newValue) => widget.onSaved(newValue),
                        onChanged: (value) => widget.onChanged(value),
                        maxLines: 5,
                        minLines: 1,
                      ))),
        // IconButton(
        //   icon: Icon(Icons.edit),
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
