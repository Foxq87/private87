// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ders/pages/calendar.dart';
import 'package:ders/pages/inbox.dart';
import 'package:ders/pages/private.dart';
import 'package:ders/pages/models.dart';
import 'package:ders/pages/tests.dart';
import 'package:ders/pages/tests_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'book_edit.dart';
import 'completed.dart';
import 'product_lists.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

TextEditingController taskTitle = TextEditingController();
TextEditingController taskDescription = TextEditingController();
void goToTestsPage(context) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Tests()));

void goToCalendar(context) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => Calendar()));

class _FirstPageState extends State<FirstPage> {
  FocusNode focusNode = FocusNode();

  bool isTmrwSelected = false;
  bool isTdySelected = true;
  bool isnwSelected = false;

  String selectedDate = 'today';
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  List<String> items = ['Today', 'Tomorrow', 'This Weekend', 'Next Week'];
  List<IconData> icons = [
    CupertinoIcons.calendar_today,
    CupertinoIcons.sun_max,
    CupertinoIcons.calendar,
    CupertinoIcons.arrow_right_square
  ];
  String? selectedItem = 'Today';

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: Row(children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Color.fromARGB(255, 255, 17, 0),
              child: Icon(CupertinoIcons.add, size: 22, color: Colors.black),
            ),
            SizedBox(width: 15),
            Text('Add Task',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromARGB(255, 255, 17, 0),
                    fontWeight: FontWeight.w500))
          ]),
          onTap: () {
            showCupertinoModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Color.fromARGB(255, 21, 21, 21),
                builder: (context) {
                  return StatefulBuilder(builder: (BuildContext context,
                      StateSetter setModalState /*You can rename this!*/) {
                    final formKey = GlobalKey<FormState>();

                    return Container(
                      height: 530,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 15),
                            child: Material(
                              color: Color.fromARGB(255, 21, 21, 21),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    autofocus: true,
                                    focusNode: focusNode,
                                    textInputAction: TextInputAction.next,
                                    style: const TextStyle(fontSize: 22.0),
                                    controller: taskTitle,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: 'e.g., Read 20 pages',
                                    ),
                                  ),
                                  TextField(
                                    maxLines: 2,
                                    textInputAction: TextInputAction.next,
                                    style: const TextStyle(fontSize: 18.0),
                                    controller: taskDescription,
                                    onChanged: (value) {},
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: 'Description',
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      // DropdownButton<String>(
                                      //  icon: Icon(null),

                                      //   // decoration: InputDecoration(
                                      //   //   enabledBorder: OutlineInputBorder(
                                      //   //     borderRadius: BorderRadius.circular(10),
                                      //   //     borderSide: BorderSide(width: 2.0,color:Colors.white30),
                                      //   //   )
                                      //   // ),
                                      //   value: selectedItem,
                                      //   items:items.map((item) => DropdownMenuItem<String>(
                                      //     value:item,
                                      //   child:
                                      //   Row(
                                      //     children: [
                                      //       Icon(),
                                      //       SizedBox(width: 5,),
                                      //       Text(item),
                                      //     ],
                                      //   ))).toList()  ,
                                      //   onChanged: (item) => setModalState(()=>selectedItem = item),
                                      //   ),

                                      GestureDetector(
                                        onTap: () {
                                          setModalState(() {
                                            selectedDate = 'today';
                                            isTdySelected = true;
                                            isTmrwSelected = false;
                                            isnwSelected = false;
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 95,
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(CupertinoIcons.calendar,
                                                  size: 20,
                                                  color: Colors.green),
                                              Text('Today',
                                                  style: TextStyle(
                                                      fontSize: 19.0,
                                                      color: Colors.green)),
                                            ],
                                          )),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: isTdySelected == true
                                                    ? Colors.green
                                                    : Colors.white30,
                                                width: isTdySelected == true
                                                    ? 2
                                                    : 1,
                                                style: BorderStyle.solid),
                                            color:
                                                Color.fromARGB(255, 21, 21, 21),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setModalState(() {
                                            selectedDate = 'tomorrow';
                                            isTmrwSelected = true;
                                            isTdySelected = false;
                                            isnwSelected = false;
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 128,
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(CupertinoIcons.sun_max,
                                                  size: 20,
                                                  color: Colors.orange),
                                              Text('Tomorrow',
                                                  style: TextStyle(
                                                      fontSize: 19.0,
                                                      color: Colors.orange)),
                                            ],
                                          )),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: isTmrwSelected == true
                                                    ? Colors.orange
                                                    : Colors.white30,
                                                width: isTmrwSelected == true
                                                    ? 2
                                                    : 1,
                                                style: BorderStyle.solid),
                                            color:
                                                Color.fromARGB(255, 21, 21, 21),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          setModalState(() {
                                            selectedDate = 'nextWeek';
                                            isnwSelected = true;
                                            isTdySelected = false;
                                            isTmrwSelected = false;
                                          });
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 130,
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                  CupertinoIcons
                                                      .arrow_right_square,
                                                  size: 20,
                                                  color: Colors.purple),
                                              Text('Next Week',
                                                  style: TextStyle(
                                                      fontSize: 19.0,
                                                      color: Colors.purple)),
                                            ],
                                          )),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: isnwSelected == true
                                                    ? Colors.purple
                                                    : Colors.white30,
                                                width: isnwSelected == true
                                                    ? 2
                                                    : 1,
                                                style: BorderStyle.solid),
                                            color:
                                                Color.fromARGB(255, 21, 21, 21),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Material(
                            color: Color.fromARGB(255, 21, 21, 21),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 10),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        CupertinoIcons.flag,
                                      ),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(CupertinoIcons.alarm),
                                      onPressed: () {}),
                                  SizedBox(
                                    width: 260,
                                  ),
                                  IconButton(
                                      icon: CircleAvatar(
                                          backgroundColor:
                                              Color.fromARGB(255, 255, 17, 0),
                                          child: Icon(CupertinoIcons.arrow_up,
                                              size: 24, color: Colors.white)),
                                      onPressed: () {
                                        //Firestore add
                                        todoAdd() {
                                          Future createTodo({
                                            required String title,
                                            required String description,
                                          }) async {
                                            final docWord = FirebaseFirestore
                                                .instance
                                                .collection('Tasks/date/' +
                                                    selectedDate)
                                                .doc(taskTitle.text.trim());

                                            final task = Task(
                                                title: taskTitle.text.trim(),
                                                description: taskDescription
                                                    .text
                                                    .trim(),
                                                    date:'');

                                            final json = task.toJson();

                                            await docWord.set(json);
                                          }

                                          createTodo(
                                              title: taskTitle.text.trim(),
                                              description:
                                                  taskDescription.text.trim());
                                        }

                                        todoAdd();

                                        //Controller cleaning
                                        taskTitle.clear();
                                        taskDescription.clear();
                                        Navigator.pop(context);
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                });

            focusNode.requestFocus();
          },
        ),
      ),
      body: SafeArea(
        child: ListView(physics: BouncingScrollPhysics(), children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back!', style: TextStyle(fontSize: 25.0)),
                Text('Student Page',
                    style: TextStyle(fontSize: 20.0, color: Colors.white70)),
              ],
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Private()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      width: 170,
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.0),
                              CircleAvatar(
                                  radius: 22.0,
                                  backgroundColor: Colors.orange,
                                  child: Icon(CupertinoIcons.doc_plaintext,
                                      color: Colors.white, size: 27)),
                              SizedBox(height: 15.0),
                              Text('Notes',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 10.0),
                            ]),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      enableDrag: false,
                      backgroundColor: Color.fromARGB(255, 21, 21, 21),
                      context: context,
                      builder: (context) => Book(context),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                        width: 170,
                        height: 110,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 13.0, right: 13, bottom: 9),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 209, 59),
                                    child: Icon(CupertinoIcons.book,
                                        color: Colors.white, size: 27),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Text('Books',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.grey[900],
                        )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Tests()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      width: 170,
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.0),
                              CircleAvatar(
                                  radius: 22.0,
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 17, 0),
                                  child: Icon(CupertinoIcons.doc,
                                      color: Colors.white, size: 27)),
                              SizedBox(height: 15.0),
                              Text('Tests',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 10.0),
                            ]),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Calendar()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      width: 170,
                      height: 110,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15.0),
                              CircleAvatar(
                                  radius: 22.0,
                                  backgroundColor: Colors.blue,
                                  child: Icon(CupertinoIcons.calendar,
                                      color: Colors.white, size: 27)),
                              SizedBox(height: 15.0),
                              Text('Calendar',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(height: 10.0),
                            ]),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          // Container(
          //   color: Colors.black,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 23.0, right: 23.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         const Text(
          //           'To - Do',
          //           style:
          //               TextStyle(fontSize: 22.0, fontWeight: FontWeight.w800),
          //         ),
          //         TextButton(
          //           onPressed: () {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => const Completed()));
          //           },
          //           child: const Text(
          //             'Completed',
          //             style: TextStyle(
          //               color: Colors.blue,
          //               fontSize: 19.0,
          //             ),
          //           ),
          //         ),
          // IconButton(
          //     icon: const Icon(Icons.add_box_outlined, size: 30.0),
          //     onPressed: () {
          //       showCupertinoDialog(
          //         context: context,
          //         builder: createDialog2,
          //       );
          //             }),
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Container(
              height: 213,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Color.fromARGB(255, 21, 21, 21)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {Navigator.push(
    context, MaterialPageRoute(builder: (context) => Inbox()));},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.tray,
                                    color: Colors.blue, size: 27),
                                SizedBox(width: 10),
                                Text(
                                  'Inbox',
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                SizedBox(width: 260),
                                Text(
                                  '11',
                                  style: TextStyle(
                                      fontSize: 19.0, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Divider(indent: 37, thickness: 0.5),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.calendar_today,
                                  color: Colors.green, size: 27),
                              SizedBox(width: 10),
                              Text(
                                'Today',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(width: 253),
                              Text(
                                '11',
                                style: TextStyle(
                                    fontSize: 19.0, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Divider(indent: 37, thickness: 0.5),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Row(
                            children: [
                              Icon(CupertinoIcons.calendar,
                                  color: Colors.purple, size: 27),
                              SizedBox(width: 10),
                              Text(
                                'Upcoming',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(width: 219),
                              Text(
                                '11',
                                style: TextStyle(
                                    fontSize: 19.0, color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Divider(indent: 37, thickness: 0.5),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Column(children: [
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(CupertinoIcons.square_grid_2x2,
                              color: Colors.orange, size: 27),
                          SizedBox(width: 10),
                          Text(
                            'Filters',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          SizedBox(width: 256),
                          Text(
                            '11',
                            style: TextStyle(
                                fontSize: 19.0, color: Colors.white70),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget Book(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context,
          StateSetter setModalState2 /*You can rename this!*/) {
        return ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7, left: 15, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: Text('Cancel', style: TextStyle(fontSize: 20.0)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text('Books', style: TextStyle(fontSize: 23, inherit: false)),
                  TextButton(
                    child: Text('Done', style: TextStyle(fontSize: 20.0)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                                radius: 17,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 17, 0),
                                child: Icon(CupertinoIcons.rectangle_stack,
                                    size: 20, color: Colors.white)),
                            Text('6',
                                style: TextStyle(inherit: false, fontSize: 20)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: Text('To Read',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                  inherit: false)),
                        ),
                      ],
                    ),
                  ),
                  height: 80,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.orange,
                                child: Icon(CupertinoIcons.time,
                                    size: 23, color: Colors.white)),
                            Text('2',
                                style: TextStyle(inherit: false, fontSize: 20)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: Text('Reading',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                  inherit: false)),
                        ),
                      ],
                    ),
                  ),
                  height: 80,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                                radius: 17,
                                backgroundColor: Colors.green,
                                child: Icon(CupertinoIcons.check_mark,
                                    size: 20, color: Colors.white)),
                            Text('13',
                                style: TextStyle(inherit: false, fontSize: 20)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 7.0),
                          child: Text('Read',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                  inherit: false)),
                        ),
                      ],
                    ),
                  ),
                  height: 80,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Books',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24.0,
                          inherit: false)),
                  MaterialButton(
                    onPressed: () {
                      final form = formKey.currentState!;
                      if (form.validate()) {
                        createBook(
                          title: bTitleController.text.trim(),
                          pageCount: bPageCountController.text.trim(),
                          duration: bDurationController.text.trim(),
                          note: bNoteController.text.trim(),
                          date: '12.07',
                        );
                        // bTitleController.clear();
                        // bPageCountController.clear();
                        // bDurationController.clear();
                        // bNoteController.clear();
                      }

                      //showFloatingSnackBar(context);
                    },
                    child: Icon(CupertinoIcons.add_circled, size: 30),
                  ),
                ],
              ),
            ),

            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('books').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<DocumentSnapshot> listOfDocumentSnap =
                      snapshot.data!.docs;

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: listOfDocumentSnap.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                  autoClose: true,
                                  onPressed: ((context) {}),
                                  backgroundColor: Colors.blue,
                                  icon: Icons.bookmark_border),
                              SlidableAction(
                                autoClose: true,
                                onPressed: ((context) {
                                  deleteBook(snapshot.data!.docs[index].id);
                                }),
                                backgroundColor: Colors.red,
                                icon: Icons.delete_outline_rounded,
                              ),
                            ],
                          ),
                          direction: Axis.horizontal,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookEdit(
                                            docToEdit:
                                                snapshot.data!.docs[index],
                                          )));
                              // showCupertinoModalBottomSheet(
                              // backgroundColor:
                              //     Colors.grey[900],
                              // context: context,
                              // builder:
                              //     (context) =>
                              //         BookEdit(
                              //           docToEdit:
                              //           snapshot
                              //               .data!
                              //               .docs[index],
                              //         ));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 2),
                              child: Container(
                                height: 110.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.grey[850],
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: listOfDocumentSnap[index]
                                                    ['image'] ==
                                                ''
                                            ? Icon(CupertinoIcons.book)
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                child: Image.network(
                                                  listOfDocumentSnap[index]
                                                      ['image'],
                                                  fit: BoxFit.cover,
                                                )),
                                        height: 95,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[900],
                                          borderRadius:
                                              BorderRadius.circular(13),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 15.0,
                                              ),
                                              child: Text(
                                                  listOfDocumentSnap[index]
                                                      ['title'],
                                                  style: TextStyle(
                                                      fontSize: 23,
                                                      inherit: false)),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                                listOfDocumentSnap[index]
                                                        ['author']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    inherit: false,
                                                    color: Colors.white70)),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        listOfDocumentSnap[index]['pageCount'] +
                                            ' page',
                                        style: TextStyle(
                                            fontSize: 19,
                                            inherit: false,
                                            color: Colors.white70),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
            //addSession(),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 15,
              ),
              child: Text('Read',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      inherit: false)),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('sessions')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List<DocumentSnapshot> listOfDocumentSnap =
                      snapshot.data!.docs;

                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 20, right: 20, bottom: 22),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listOfDocumentSnap.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                  autoClose: true,
                                  onPressed: ((context) {}),
                                  backgroundColor: Colors.blue,
                                  icon: Icons.bookmark_border),
                              SlidableAction(
                                autoClose: true,
                                onPressed: ((context) {
                                  deleteBook(snapshot.data!.docs[index].id);
                                }),
                                backgroundColor: Colors.red,
                                icon: Icons.delete_outline_rounded,
                              ),
                            ],
                          ),
                          direction: Axis.horizontal,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookEdit(
                                            docToEdit:
                                                snapshot.data!.docs[index],
                                          )));
                              // showCupertinoModalBottomSheet(
                              // backgroundColor:
                              //     Colors.grey[900],
                              // context: context,
                              // builder:
                              //     (context) =>
                              //         BookEdit(
                              //           docToEdit:
                              //           snapshot
                              //               .data!
                              //               .docs[index],
                              //         ));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 2),
                              child: Container(
                                height: 81.7,
                                decoration: BoxDecoration(
                                  color: Colors.grey[850],
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(listOfDocumentSnap[index]['title'],
                                          style: TextStyle(
                                              fontSize: 23, inherit: false)),
                                      SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              listOfDocumentSnap[index]['date']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  inherit: false,
                                                  color: Colors.white70)),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 20.0),
                                            child: Text(
                                                listOfDocumentSnap[index]
                                                        ['pageCount'] +
                                                    ' page',
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    inherit: false,
                                                    color: Colors.white70)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ],
        );
      },
    );
  }

  Widget toDo() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('To-Do').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 700,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 20.0,
                        right: 20,
                      ),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.redAccent,
                              icon: Icons.delete_outline_rounded,
                              onPressed: ((context) {
                                delete(snapshot.data!.docs[index].id);
                              }),
                            ),
                            SlidableAction(
                              backgroundColor: Colors.green,
                              icon: Icons.verified_rounded,
                              onPressed: ((context) {
                                delete(snapshot.data!.docs[index].id);

                                todoAdd() {
                                  Future createTodo({
                                    required String todo,
                                  }) async {
                                    final docWord = FirebaseFirestore.instance
                                        .collection('Done')
                                        .doc(snapshot.data!.docs[index].id);

                                    final todo2 = Todo2(
                                        todo: snapshot.data!.docs[index]
                                            ['todo'],
                                        snapshotData:
                                            snapshot.data!.docs[index]);

                                    final json = todo2.toJson();

                                    await docWord.set(json);
                                  }

                                  createTodo(
                                      todo: snapshot.data!.docs[index]['todo']);
                                }

                                todoAdd();
                              }),
                            ),
                          ],
                        ),
                        child: Flexible(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: Colors.grey[900],
                            title: Text(
                              snapshot.data!.docs[index]['todo'],
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        );
      },
    );
  }

  Widget addSession() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Today',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      inherit: false)),
              MaterialButton(
                onPressed: () {
                  final form = formKey.currentState!;
                  if (form.validate()) {
                    createBook(
                      title: bTitleController.text.trim(),
                      pageCount: bPageCountController.text.trim(),
                      duration: bDurationController.text.trim(),
                      note: bNoteController.text.trim(),
                      date: '12.07',
                    );
                    // bTitleController.clear();
                    // bPageCountController.clear();
                    // bDurationController.clear();
                    // bNoteController.clear();
                  }

                  //showFloatingSnackBar(context);
                },
                child: Icon(Icons.add_box_outlined, size: 30),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
          child: Form(
            key: formKey,
            child: CupertinoFormSection(
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(8),
              ),
              // header: const Text('Add',style: TextStyle(color: Colors.white70,fontSize: 20.0)),
              children: [
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    controller: bTitleController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    validator: (bTitleController) {
                      if (bTitleController == null ||
                          bTitleController.isEmpty) {
                        return 'Field is required.';
                      } else {
                        return null;
                      }
                    },
                    decoration: const BoxDecoration(),
                    placeholder: "required",
                    placeholderStyle: const TextStyle(color: Colors.white70),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  prefix: const Text('Title',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500)),
                ),
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: bPageCountController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    //controller: ,
                    validator: (bPageCountController) {
                      if (bPageCountController == null ||
                          bPageCountController.isEmpty) {
                        return 'Field is required.';
                      } else {
                        return null;
                      }
                    },
                    decoration: const BoxDecoration(),
                    placeholder: "required",
                    placeholderStyle: const TextStyle(color: Colors.white70),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  prefix: const Text('Page Count',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500)),
                ),
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: bDurationController,
                    textInputAction: TextInputAction.next,
                    decoration: const BoxDecoration(),
                    placeholder: "required",
                    placeholderStyle: const TextStyle(color: Colors.white70),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  prefix: const Text('Duration',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500)),
                ),
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    controller: bNoteController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.next,
                    //controller: ,
                    validator: (bNoteController) {
                      if (bNoteController == null || bNoteController.isEmpty) {
                        return 'Field is required.';
                      } else {
                        return null;
                      }
                    },
                    decoration: const BoxDecoration(),
                    placeholder: "required",
                    placeholderStyle: const TextStyle(color: Colors.white70),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  prefix: const Text('Note',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void deleteBook(String id) {
  FirebaseFirestore.instance.collection('books').doc(id).delete();
}
