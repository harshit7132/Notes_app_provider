import 'package:flutter/material.dart';
import 'package:notes_app_provider_new/Database/Note%20Model.dart';
import 'package:provider/provider.dart';
import 'Provider/Note Provider.dart';

class add_Notes_page extends StatelessWidget {
  String? title;
  String? desc;
  int? note_id;
  bool isupDate = false;

  add_Notes_page(
      {super.key, required this.isupDate, this.title, this.desc, this.note_id});

  var titleController = TextEditingController();
  var descController = TextEditingController();
  String operationTitle = 'Add Notes';
  @override
  Widget build(BuildContext context) {
    void addNotes(String title, String desc) async {
      context
          .read<NoteProvider>()
          .addNotes(noteModel(title: title, desc: desc));
    }

    updateNotes(int? note_id,String title, String desc) {
      context
          .read<NoteProvider>()
          .updateNotes(noteModel(note_id: note_id,title: title,desc: desc));
    }

    initController() {
      titleController.text = title!;
      descController.text = desc!;
    }

    if (isupDate) {
      initController();
      operationTitle = 'Update Notes';
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(operationTitle),
          TextField(
            controller: titleController,
          ),
          TextField(
            controller: descController,
          ),
          ElevatedButton(
              onPressed: () {
                var title = titleController.text.toString();
                var desc = descController.text.toString();
                if (isupDate) {
                  updateNotes(note_id,title,desc);
                  Navigator.pop(context);
                } else {
                  addNotes(title, desc);
                  Navigator.pop(context);
                }
              },
              child: Text(operationTitle))
        ],
      ),
    );
  }
}
