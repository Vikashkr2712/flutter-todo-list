import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/const/colors.dart';
import 'package:flutter_to_do_list/data/firestor.dart';
import 'package:flutter_to_do_list/model/notes_model.dart';

// ignore: must_be_immutable
class Edit_Screen extends StatefulWidget {
  Note _note;
  Edit_Screen(this._note, {super.key});

  @override
  State<Edit_Screen> createState() => _Edit_ScreenState();
}

class _Edit_ScreenState extends State<Edit_Screen> {
  TextEditingController? title;
  TextEditingController? subtitle;

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  int indexx = 0;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget._note.title);
    subtitle = TextEditingController(text: widget._note.subtitle);
    indexx = widget._note.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Edit Your Task ✏️',
          style: TextStyle(
            color: Colors.teal.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              title_widgets(),
              SizedBox(height: 20),
              subtitle_widget(),
              SizedBox(height: 25),
              imagess(),
              SizedBox(height: 30),
              button()
            ],
          ),
        ),
      ),
    );
  }

  Widget button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: Icon(Icons.save_alt_rounded, size: 20),
          style: ElevatedButton.styleFrom(
            backgroundColor: custom_green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
          onPressed: () {
            Firestore_Datasource().Update_Note(
              widget._note.id,
              indexx,
              title!.text,
              subtitle!.text,
            );
            Navigator.pop(context);
          },
          label: Text('Update Task', style: TextStyle(fontSize: 16)),
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.cancel_outlined),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
          onPressed: () => Navigator.pop(context),
          label: Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget imagess() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pick a Cover Image",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: 16,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    indexx = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: indexx == index ? custom_green : Colors.grey,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      if (indexx == index)
                        BoxShadow(
                          color: custom_green.withOpacity(0.4),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'images/$index.png',
                      width: 140,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget title_widgets() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: title,
        focusNode: _focusNode1,
        style: TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: 'Enter Title',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget subtitle_widget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        maxLines: 4,
        controller: subtitle,
        focusNode: _focusNode2,
        style: TextStyle(fontSize: 16, color: Colors.black87),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: 'Enter Description...',
          border: InputBorder.none,
        ),
      ),
    );
  }
}
