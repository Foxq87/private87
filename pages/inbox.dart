import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ders/pages/calendar.dart';
import 'package:ders/pages/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Inbox extends StatefulWidget {
  const Inbox({Key? key}) : super(key: key);

  @override
  State<Inbox> createState() => _InboxState();
}

bool selected = false;
TextEditingController title2 = TextEditingController();
TextEditingController description2 = TextEditingController();

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 15, 15, 15),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.search),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.more_horiz_rounded, size: 27),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text('Inbox'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Tasks/date/today')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<DocumentSnapshot> listOfDocumentSnap = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: listOfDocumentSnap.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        enableDrag: false,
                          backgroundColor: Color.fromARGB(255, 21, 21, 21),
                          context: context,
                          builder: (context) => TaskEditor(
                                docToEdit: snapshot.data!.docs[index],
                              ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 5.0,
                      ),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.redAccent,
                              icon: Icons.delete_outline_rounded,
                              onPressed: ((context) {
                                deleteTask(snapshot.data!.docs[index].id);
                              }),
                            ),
                            SlidableAction(
                              backgroundColor: Colors.green,
                              icon: Icons.verified_rounded,
                              onPressed: ((context) {
                                deleteTask(snapshot.data!.docs[index].id);
                              }),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 79,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected == true
                                              ? selected = false
                                              : selected = true;
                                        });
                                        deleteTask(
                                            snapshot.data!.docs[index].id);
                                        setState(() {
                                          selected = false;
                                        });
                                      },
                                      child: Container(
                                        child: Center(
                                          child: Container(
                                            child: Center(
                                              child: Container(
                                                child: selected == true
                                                    ? Icon(
                                                        CupertinoIcons
                                                            .check_mark,
                                                        size: 17,
                                                      )
                                                    : Container(),
                                                height: 21.0,
                                                width: 21.0,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            500),
                                                    color: selected == true
                                                        ? Color.fromARGB(
                                                            255, 100, 100, 100)
                                                        : Color.fromARGB(
                                                            255, 0, 0, 0)),
                                              ),
                                            ),
                                            height: 26.0,
                                            width: 26.0,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(500),
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                          ),
                                        ),
                                        height: 29,
                                        width: 29,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            color: Color.fromARGB(
                                                255, 100, 100, 100)),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          listOfDocumentSnap[index]
                                              ['taskTitle'],
                                          style: TextStyle(fontSize: 20.0)),

                                      //                                     listOfDocumentSnap[index]['taskDescription'] != '' ? Text(listOfDocumentSnap[index]['taskDescription'],overflow: TextOverflow.ellipsis,
                                      //                                     style: TextStyle(fontSize: 18.0,color:Colors.white70),): Container(),
                                      SizedBox(height: 2),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 55.0),
                                child: Row(
                                  children: [
                                    Icon(CupertinoIcons.today,
                                        color: Colors.green),
                                    SizedBox(width: 3),
                                    Text('Today',
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.green))
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(
                                indent: 55,
                                thickness: 0.35,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }

  // Widget taskEditor(BuildContext context, int index) {
  //   return StatefulBuilder(
  //       builder: (BuildContext context, StateSetter setModalState) {
  //     return StreamBuilder<QuerySnapshot>(
  //         stream: FirebaseFirestore.instance
  //             .collection('Tasks/date/today')
  //             .snapshots(),
  //         builder:
  //             (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //           if (!snapshot.hasData) {
  //             return Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           }
  //           List<DocumentSnapshot> listOfDocumentSnap = snapshot.data!.docs;

  //           return editing == true
  //               ? Material(
  //                   color: Color.fromARGB(255, 21, 21, 21),
  //                   child: Container(
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(
  //                           left: 20.0, right: 20, top: 9),
  //                       child: Column(
  //                         children: [
  //                           Container(
  //                             width: 40.0,
  //                             height: 5.0,
  //                             decoration: BoxDecoration(
  //                               color: Colors.grey[700],
  //                               borderRadius: BorderRadius.circular(50),
  //                             ),
  //                           ),
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               TextButton(
  //                                   onPressed: () {
  //                                     setModalState(() {
  //                                       editing = false;
  //                                     });
  //                                   },
  //                                   child: Text('Cancel',
  //                                       style: TextStyle(
  //                                           color:
  //                                               Color.fromARGB(255, 255, 17, 0),
  //                                           fontWeight: FontWeight.w500,
  //                                           fontSize: 20,
  //                                           inherit: false))),
  //                               Text('Edit Task',
  //                                   style: TextStyle(
  //                                       fontSize: 22,
  //                                       fontWeight: FontWeight.w500)),
  //                               TextButton(
  //                                   onPressed: () {},
  //                                   child: Text('  Save',
  //                                       style: TextStyle(
  //                                           color:
  //                                               Color.fromARGB(255, 255, 17, 0),
  //                                           fontWeight: FontWeight.w500,
  //                                           fontSize: 20,
  //                                           inherit: false)))
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 decoration: BoxDecoration(
  //                                   color: Colors.white10,
  //                                   borderRadius: BorderRadius.circular(50),
  //                                 ),
  //                                 height: 29,
  //                                 width: 29,
  //                                 child: Center(
  //                                   child: Container(
  //                                     height: 25,
  //                                     width: 25,
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.black,
  //                                       borderRadius: BorderRadius.circular(50),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               SizedBox(width: 10),
  //                               Expanded(
  //                                 child: TextField(
  //                                   controller: title,
  //                                   decoration: const InputDecoration(
  //                                     border: InputBorder.none,
  //                                     enabledBorder: InputBorder.none,
  //                                     errorBorder: InputBorder.none,
  //                                     focusedBorder: InputBorder.none,
  //                                     hintText: 'Type Your Task',
  //                                     hintStyle: TextStyle(
  //                                         fontSize: 20,
  //                                         fontWeight: FontWeight.w500),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               Icon(
  //                                 CupertinoIcons.text_alignleft,
  //                                 size: 25,
  //                                 color: Colors.white70,
  //                               ),
  //                               SizedBox(width: 10),
  //                               Expanded(
  //                                 child: TextField(
  //                                   controller: description,
  //                                   decoration: const InputDecoration(
  //                                     border: InputBorder.none,
  //                                     enabledBorder: InputBorder.none,
  //                                     errorBorder: InputBorder.none,
  //                                     focusedBorder: InputBorder.none,
  //                                     hintText: 'Description',
  //                                     hintStyle: TextStyle(
  //                                         fontSize: 20,
  //                                         fontWeight: FontWeight.w500),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               : Material(
  //                   color: Color.fromARGB(255, 21, 21, 21),
  //                   child: Container(
  //                     height: 550.0,
  //                     child: ListView(
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(
  //                               left: 20.0, right: 15.0, top: 9.0),
  //                           child: Column(
  //                             children: [
  //                               Container(
  //                                 width: 40.0,
  //                                 height: 5.0,
  //                                 decoration: BoxDecoration(
  //                                   color: Colors.grey[700],
  //                                   borderRadius: BorderRadius.circular(50),
  //                                 ),
  //                               ),
  //                               SizedBox(height: 20.0),
  //                               Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   GestureDetector(
  //                                     onTap: () {},
  //                                     child: Row(
  //                                       children: [
  //                                         Icon(CupertinoIcons.tray,
  //                                             color: Colors.blue, size: 25),
  //                                         SizedBox(width: 10.0),
  //                                         Text(
  //                                           'Inbox',
  //                                           style: TextStyle(
  //                                               inherit: false,
  //                                               fontSize: 18,
  //                                               fontWeight: FontWeight.w500,
  //                                               color: Colors.white70),
  //                                         ),
  //                                         SizedBox(width: 5.0),
  //                                         Icon(Icons.arrow_forward_ios_rounded,
  //                                             color: Colors.white70, size: 15),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Row(
  //                                     children: [
  //                                       IconButton(
  //                                           onPressed: () {},
  //                                           icon: CircleAvatar(
  //                                               backgroundColor:
  //                                                   Colors.grey[800],
  //                                               child: Icon(
  //                                                   Icons.more_horiz_outlined,
  //                                                   color: Colors.white))),
  //                                       IconButton(
  //                                           onPressed: () {
  //                                             Navigator.pop(context);
  //                                           },
  //                                           icon: CircleAvatar(
  //                                               backgroundColor:
  //                                                   Colors.grey[800],
  //                                               child: Icon(Icons.close,
  //                                                   color: Colors.white))),
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                               GestureDetector(
  //                                 onTap: () {},
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.only(
  //                                     bottom: 5.0,
  //                                   ),
  //                                   child: Column(
  //                                     children: [
  //                                       Row(
  //                                         mainAxisAlignment:
  //                                             MainAxisAlignment.start,
  //                                         children: [
  //                                           Padding(
  //                                             padding: const EdgeInsets.only(
  //                                                 left: 15.0, right: 15),
  //                                             child: GestureDetector(
  //                                               onTap: () {
  //                                                 setModalState(() {
  //                                                   selected == true
  //                                                       ? selected = false
  //                                                       : selected = true;
  //                                                 });
  //                                                 deleteTask(snapshot
  //                                                     .data!.docs[index].id);
  //                                                 setState(() {
  //                                                   selected = false;
  //                                                 });
  //                                               },
  //                                               child: Container(
  //                                                 child: Center(
  //                                                   child: Container(
  //                                                     child: Center(
  //                                                       child: Container(
  //                                                         child:
  //                                                             selected == true
  //                                                                 ? Icon(
  //                                                                     CupertinoIcons
  //                                                                         .check_mark,
  //                                                                     size: 17,
  //                                                                   )
  //                                                                 : Container(),
  //                                                         height: 21.0,
  //                                                         width: 21.0,
  //                                                         decoration: BoxDecoration(
  //                                                             borderRadius:
  //                                                                 BorderRadius
  //                                                                     .circular(
  //                                                                         500),
  //                                                             color: selected ==
  //                                                                     true
  //                                                                 ? Color
  //                                                                     .fromARGB(
  //                                                                         255,
  //                                                                         100,
  //                                                                         100,
  //                                                                         100)
  //                                                                 : Color
  //                                                                     .fromARGB(
  //                                                                         255,
  //                                                                         0,
  //                                                                         0,
  //                                                                         0)),
  //                                                       ),
  //                                                     ),
  //                                                     height: 26.0,
  //                                                     width: 26.0,
  //                                                     decoration: BoxDecoration(
  //                                                         borderRadius:
  //                                                             BorderRadius
  //                                                                 .circular(
  //                                                                     500),
  //                                                         color: Color.fromARGB(
  //                                                             255, 0, 0, 0)),
  //                                                   ),
  //                                                 ),
  //                                                 height: 29,
  //                                                 width: 29,
  //                                                 decoration: BoxDecoration(
  //                                                     borderRadius:
  //                                                         BorderRadius.circular(
  //                                                             500),
  //                                                     color: Color.fromARGB(
  //                                                         255, 100, 100, 100)),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           GestureDetector(
  //                                             onTap: () {
  //                                               setModalState(() {
  //                                                 editing = true;
  //                                               });
  //                                             },
  //                                             child: Text(
  //                                                 listOfDocumentSnap[index]
  //                                                     ['taskTitle'],
  //                                                 style: TextStyle(
  //                                                     fontSize: 20.0)),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       Padding(
  //                                         padding: const EdgeInsets.only(
  //                                           left: 15.0,
  //                                           top: 15,
  //                                         ),
  //                                         child: Row(
  //                                           children: [
  //                                             Icon(
  //                                                 CupertinoIcons.text_alignleft,
  //                                                 size: 25,
  //                                                 color: Colors.white70),
  //                                             SizedBox(width: 5),
  //                                             Text('Description',
  //                                                 style: TextStyle(
  //                                                     fontSize: 19,
  //                                                     color: Colors.white70))
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       Padding(
  //                                         padding: const EdgeInsets.only(
  //                                             left: 15.0, top: 15),
  //                                         child: Row(
  //                                           children: [
  //                                             Icon(CupertinoIcons.today,
  //                                                 size: 25,
  //                                                 color: Colors.green),
  //                                             SizedBox(width: 3),
  //                                             Text('Today',
  //                                                 style: TextStyle(
  //                                                     fontSize: 17,
  //                                                     color: Colors.green))
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //         });
  //   });
  // }
}

bool editing = false;

void deleteTask(String id) {
  FirebaseFirestore.instance.collection('Tasks/date/today').doc(id).delete();
}

class TaskEditor extends StatefulWidget {
  DocumentSnapshot docToEdit;
  TaskEditor({Key? key, required this.docToEdit}) : super(key: key);

  @override
  State<TaskEditor> createState() => _TaskEditorState();
}

class _TaskEditorState extends State<TaskEditor> {
  @override
  void initState() {
    title2 = TextEditingController(text: widget.docToEdit['taskTitle']);
    description2 =
        TextEditingController(text: widget.docToEdit['taskDescription']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return editing == true
        ? Material(
            color: Color.fromARGB(255, 21, 21, 21),
            child: Container(
              height: 550,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 9,),
                child: Column(
                  children: [
                    Container(
                      width: 40.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(height:10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                editing = false;
                              });
                            },
                            child: Text('Cancel',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 17, 0),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    inherit: false))),
                        Text('Edit Task',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500)),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                editing = false;
                                void updateWord(title, description, date) {
                                  FirebaseFirestore.instance
                                      .collection('Tasks/date/today')
                                      .doc(widget.docToEdit.id)
                                      .update({
                                    'taskTitle': title2.text.trim(),
                                    'taskDescription': description2.text.trim(),
                                    'date': formattedDate,
                                  });
                                }

                                updateWord(
                                  widget.docToEdit['taskTitle'],
                                  widget.docToEdit['taskDescription'],
                                  widget.docToEdit['date'],
                                );
                              });
                              Navigator.pop(context);
                            },
                            child: Text('  Save',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 17, 0),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    inherit: false)))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:15.0,),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            height: 29,
                            width: 29,
                            child: Center(
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              controller: title2,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Type Your Task',
                                hintStyle: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:17.0,),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.text_alignleft,
                            size: 25,
                            color: Colors.white70,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                                  style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w500,color:Colors.white70),
                              controller: description2,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: 'Description',
                                hintStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height:10,),
                  ],
                ),
              ),
            ),
          )
        : Material(
            color: Color.fromARGB(255, 21, 21, 21),
            child: Container(
              height: 550.0,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                         top: 9.0),
                    child: Column(
                      children: [
                        Container(
                          width: 40.0,
                          height: 5.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(left:23.0),
                                child: Row(
                                  children: [
                                    Icon(CupertinoIcons.tray,
                                        color: Colors.blue, size: 23),
                                    SizedBox(width: 10.0),
                                    Text(
                                      'Inbox',
                                      style: TextStyle(
                                          inherit: false,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white70),
                                    ),
                                    SizedBox(width: 5.0),
                                    Icon(Icons.arrow_forward_ios_rounded,
                                        color: Colors.white70, size: 15),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right:10.0),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: CircleAvatar(
                                          backgroundColor: Colors.grey[800],
                                          child: Icon(Icons.more_horiz_outlined,
                                              color: Colors.white))),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: CircleAvatar(
                                          backgroundColor: Colors.grey[800],
                                          child: Icon(Icons.close,
                                              color: Colors.white))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 5.0,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 15),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selected == true
                                                ? selected = false
                                                : selected = true;
                                          });
                                          deleteTask(widget.docToEdit.id);
                                          setState(() {
                                            selected = false;
                                          });
                                        },
                                        child: Container(
                                          child: Center(
                                            child: Container(
                                              child: Center(
                                                child: Container(
                                                  child: selected == true
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .check_mark,
                                                          size: 17,
                                                        )
                                                      : Container(),
                                                  height: 21.0,
                                                  width: 21.0,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500),
                                                      color: selected == true
                                                          ? Color.fromARGB(255,
                                                              100, 100, 100)
                                                          : Color.fromARGB(
                                                              255, 0, 0, 0)),
                                                ),
                                              ),
                                              height: 26.0,
                                              width: 26.0,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          500),
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)),
                                            ),
                                          ),
                                          height: 29,
                                          width: 29,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(500),
                                              color: Color.fromARGB(
                                                  255, 100, 100, 100)),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          editing = true;
                                        });
                                      },
                                      child: Text(widget.docToEdit['taskTitle'],
                                          style: TextStyle(fontSize: 20.0)),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left:23,
                                    top: 15,
                                    bottom: 5
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(CupertinoIcons.text_alignleft,
                                          size: 23, color: Colors.white70),
                                      SizedBox(width: 17),
                                      Text('Description',
                                          style: TextStyle(
                                              fontSize: 19,
                                              color: Colors.white70))
                                    ],
                                  ),
                                ),
                                Divider(
                                  indent: 50,
                                  thickness: 0.5,
                                  color:Colors.white70
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                     left:20, top: 5,bottom: 20),
                                  child: Row(
                                    children: [
                                      Icon(CupertinoIcons.today,
                                          size: 30, color: Colors.green),
                                      SizedBox(width: 5),
                                      Text('Today',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.green))
                                    ],
                                  ),
                                ),

                               
                              
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),   Padding(
                                  padding: const EdgeInsets.only(left:5,bottom:13.0),
                                  child: SizedBox(
                                    height:45,
                                    child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        SizedBox(width:15),
                                        Container(
                                          decoration: BoxDecoration(
                                          color:Colors.grey[800],
                                          borderRadius: BorderRadius.circular(10)),
                                          height: 30,
                                          width:100,
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(CupertinoIcons.flag,size:20),
                                              Text('Priority',style:TextStyle(fontSize:18,fontWeight: FontWeight.w500)),
                                            ],
                                          )
                                        ),
                                        SizedBox(width:10),
                                         Container(
                                          decoration: BoxDecoration(
                                          color:Colors.grey[800],
                                          borderRadius: BorderRadius.circular(10)),
                                          height: 30,
                                          width:115,
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(CupertinoIcons.alarm,size:20),
                                              Text('Reminder',style:TextStyle(fontSize:18,fontWeight: FontWeight.w500)),
                                            ],
                                          )
                                        ),
                                        SizedBox(width:10),
                                        Container(
                                          decoration: BoxDecoration(
                                          color:Colors.grey[800],
                                          borderRadius: BorderRadius.circular(10)),
                                          height: 30,
                                          width:105,
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(CupertinoIcons.flag,size:22),
                                              Text('Priority',style:TextStyle(fontSize:18,fontWeight: FontWeight.w500)),
                                            ],
                                          )
                                        ),
                                        SizedBox(width:10),
                                        Container(
                                          decoration: BoxDecoration(
                                          color:Colors.grey[800],
                                          borderRadius: BorderRadius.circular(10)),
                                          height: 30,
                                          width:105,
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(CupertinoIcons.flag,size:22),
                                              Text('Priority',style:TextStyle(fontSize:18,fontWeight: FontWeight.w500)),
                                            ],
                                          )
                                        ),
                                        SizedBox(width:10),
                                       
                                        SizedBox(width:10),
                                        ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 6,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left:20.0,top:10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.add,size:30,color:Colors.white70),
                                      SizedBox(width: 10,),
                                      Text('Add Sub-Task',    style: TextStyle(
                                    fontSize: 19, ),)
                                    ],
                                  ),
                                ),
                ],
              ),
            ),
          );
  }
}
