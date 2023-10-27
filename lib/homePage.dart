import 'package:flutter/material.dart';
import 'package:note/addNotes.dart';
import 'package:note/detailsPage.dart';
import 'package:note/noteModel.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List<Note> noteList =[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes'),),

      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.edit,size: 35,weight: 20,),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotes(onAddTap: (Note note){
            addNote(note);
          })));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
              child: TextField(
                decoration: InputDecoration(
                  constraints: const BoxConstraints(
                    maxHeight: 40,
                    //maxWidth: 350
                  ),
                  hintText: 'Search notes',
                    contentPadding: const EdgeInsets.only(
                      top: 7, // Adjust top padding to center the hint text
                    ),
                  prefixIcon: IconButton(
                    icon:  const Padding(
                      padding:  EdgeInsets.only(top: 2,left: 8),
                      child: Icon(Icons.search),
                    ),
                    onPressed: (){},
                  ),
                  border: InputBorder.none,
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(30),
              // )
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                  itemCount: noteList.length,
                  itemBuilder: (context,index){
                    final Note note = noteList[index];
                    final String formattedDate =DateFormat('MMMM d').format(note.createDateTime);
                return   GestureDetector(
                  onLongPress: (){
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: const Text('Alert'),
                        content: const Text('Do you went to Delete note ?'),
                        actions: [
                          ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                            ), child: const Text('Cancel'),
                          ),

                          ElevatedButton(onPressed: (){
                            deleteNote(index);
                            Navigator.pop(context);
                          },style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                          ), child: const Text('Delete'),),
                        ],
                      );
                    });
                  },

                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    DetailsPage(note: note, onNoteUpdate: (String updateNoteText,String updateDetailsNote){
                      updateNote(index, updateNoteText, updateDetailsNote);
                    })
                    ));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation:0,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Text(note.title),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(note.details),
                             Padding(
                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                              child: Text(formattedDate),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
  void addNote(Note note){
    noteList.add(note);
    setState(() {});
  }

  void updateNote(int index, String noteTitle,noteDetails){
    noteList[index].title=noteTitle;
    noteList[index].details=noteDetails;
    setState(() {});
  }

  void deleteNote(int index){
    noteList.removeAt(index);
    setState(() {});
  }

}


