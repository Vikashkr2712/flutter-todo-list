import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/const/colors.dart';
import 'package:flutter_to_do_list/data/firestor.dart';
import 'package:intl/intl.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final title = TextEditingController();
  final subtitle = TextEditingController();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  int indexx = 0;

  String getFormattedDate() {
    return DateFormat('EEE, MMM d • hh:mm a').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Column(
            children: [
              _header(),
              SizedBox(height: 30),
              _titleWidget(),
              SizedBox(height: 20),
              _subtitleWidget(),
              SizedBox(height: 25),
              _imagePicker(),
              SizedBox(height: 30),
              _actionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📝 Create New Task',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: custom_green,
          ),
        ),
        SizedBox(height: 5),
        Text(
          getFormattedDate(),
          style: TextStyle(color: Colors.grey[700], fontSize: 16),
        ),
      ],
    );
  }

  Widget _titleWidget() {
    return _styledTextField(
      controller: title,
      focusNode: _focusNode1,
      hint: 'Enter task title...',
    );
  }

  Widget _subtitleWidget() {
    return _styledTextField(
      controller: subtitle,
      focusNode: _focusNode2,
      hint: 'Write something about the task...',
      maxLines: 3,
    );
  }

  Widget _styledTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLines: maxLines,
        style: TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.all(16),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _imagePicker() {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: 16,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() => indexx = index);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: indexx == index ? custom_green : Colors.grey.shade400,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'images/${index}.png',
                  fit: BoxFit.cover,
                  width: 140,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _actionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: custom_green,
            minimumSize: Size(160, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            Firestore_Datasource().AddNote(subtitle.text, title.text, indexx);
            Navigator.pop(context);
          },
          icon: Icon(Icons.check),
          label: Text('Add Task'),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            minimumSize: Size(160, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.cancel),
          label: Text('Cancel'),
        ),
      ],
    );
  }
}
