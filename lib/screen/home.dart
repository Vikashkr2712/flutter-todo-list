import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_to_do_list/const/colors.dart';
import 'package:flutter_to_do_list/screen/add_note_screen.dart'; // Make sure this contains AddScreen class
import 'package:flutter_to_do_list/widgets/stream_note.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool show = true;

class _Home_ScreenState extends State<Home_Screen> {
  late String currentTime;

  bool hasPendingTasks = true;
  bool hasDoneTasks = true;

  @override
  void initState() {
    super.initState();
    _updateDateTime();
  }

  void _updateDateTime() {
    final now = DateTime.now();
    currentTime = DateFormat('EEEE, MMM d, yyyy – h:mm a').format(now);
  }

  @override
  Widget build(BuildContext context) {
    _updateDateTime();

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: AnimatedSlide(
        duration: Duration(milliseconds: 300),
        offset: show ? Offset.zero : Offset(0, 2),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 300),
          opacity: show ? 1.0 : 0.0,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddScreen(), // ✅ FIXED HERE
              ));
            },
            backgroundColor: custom_green,
            child: Icon(Icons.add, size: 30),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffe0f7fa), Color(0xffc8e6c9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              if (notification.direction == ScrollDirection.forward) {
                setState(() {
                  show = true;
                });
              }
              if (notification.direction == ScrollDirection.reverse) {
                setState(() {
                  show = false;
                });
              }
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your To-Do List 📝",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade900,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          currentTime,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.teal.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  hasPendingTasks
                      ? Stream_note(false)
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "All tasks are done! 🎉",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade800,
                            ),
                          ),
                        ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffE2F6F1),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Text(
                        'The Tasks Below are Done!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  hasDoneTasks
                      ? Column(
                          children: [
                            Stream_note(true),
                            Lottie.asset(
                              'images/Animation1.json',
                              height: 150,
                              repeat: false,
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "No completed tasks yet!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.redAccent.shade200,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
