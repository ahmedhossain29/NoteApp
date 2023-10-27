import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note/noteModel.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key, required this.onAddTap, });

  final Function (Note) onAddTap;

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {

bool isEditing = false;

 final TextEditingController titleController = TextEditingController();
 final TextEditingController detailsController = TextEditingController();

 final date = DateTime.now();
 final formattedDate = DateFormat('MMMM d  hh:mm a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

        body: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back)),
                  // IconButton(
                  //   icon: const Icon(Icons.done),
                  //   onPressed: () {
                  //    Note note =Note(title: titleController.text.trim(),
                  //                  details: detailsController.text.trim(), createDateTime: DateTime.now(), updateDateTime: DateTime.now());
                  //    widget.onAddTap(note);
                  //    Navigator.pop(context);
                  //   },
                  // ),
                  IconButton(onPressed: (){
                    if(isEditing){
                      Note note =Note(title: titleController.text.trim(),
                                      details: detailsController.text.trim(), createDateTime: DateTime.now(), updateDateTime: DateTime.now());
                        widget.onAddTap(note);
                        Navigator.pop(context);
                    }
                    else{

                    }
                  }, icon: Icon(isEditing ? Icons.done : Icons.more_vert),)

                ],
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                  controller: titleController,
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                         top: 10, bottom: 15,left: 10, right: 10),
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 30),
                    border: InputBorder.none,
                  ),
                  onChanged: (text) {
                    setState(() {
                      isEditing = titleController.text.isNotEmpty || detailsController.text.isNotEmpty;
                    });
                  },
                  cursorHeight: 30,

                ),
              ),
               Text(formattedDate),
              const SizedBox(height: 15,),
              Expanded(
                child: TextField(
                  controller: detailsController,
                  decoration: const InputDecoration(
                    hintText: 'Start typing',
                    border: InputBorder.none,
                  ),
                  onChanged: (text) {
                    setState(() {
                      isEditing = titleController.text.isNotEmpty || detailsController.text.isNotEmpty;
                    });
                  },

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
