import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'noteModel.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.note,
    required this.onNoteUpdate
  });

  final Note note;
  final void Function(String,String) onNoteUpdate;


  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
 late TextEditingController noteTitleController;
 late TextEditingController noteDetailsController;

 bool isEditing =false;



  @override

  void initState(){
  super.initState();
  noteTitleController = TextEditingController(text: widget.note.title);
  noteDetailsController = TextEditingController(text: widget.note.details);
  }

 final date = DateTime.now();
 final formattedDate = DateFormat('MMMM d  hh:mm a').format(DateTime.now());

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
                  IconButton(onPressed: (){
                    widget.onNoteUpdate(noteTitleController.text.trim(),noteDetailsController.text.trim());

                    Navigator.pop(context);
                  }, icon: const Icon(Icons.done)),
                ],
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: TextField(
                  controller: noteTitleController,
                  cursorHeight: 25,
                  cursorRadius: const Radius.circular(5.0),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 30),
                    border: InputBorder.none,
                  ),
                ),
              ),
               Text(formattedDate),
              const SizedBox(height: 20,),
               Expanded(
                child: TextField(

                  controller: noteDetailsController,
                  decoration: const InputDecoration(
                    hintText: 'Start typing',
                    border: InputBorder.none,
                  ),

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
