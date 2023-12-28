import 'package:flutter/material.dart';
import 'package:task_manager_app/pages/profile/index.dart';
import '../classes/index.dart';
import '../components/find_component/index.dart';
import '../components/view_authorized/index.dart';
import '../components/create_component/index.dart';
import '../components/view_created_component/index.dart';
import '../components/request/index.dart';

class MainPage extends StatefulWidget {
  final User? user;
  const MainPage({super.key, required this.user});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String pageTitle = 'Create Task';
  int currentTab = 0;
  dynamic displayIcon = Icons.add_box_outlined;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Icon(
                      displayIcon,
                      color: const Color.fromARGB(255, 253, 253, 228),
                      size: 50,
                    ),
                  ),
                  Text(
                    pageTitle,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 1, 64, 116),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileMain(
                        user: widget.user,
                      ),
                    ),
                  );
                },
                child: const Icon(
                  Icons.person_pin_circle_sharp,
                  size: 50,
                  color: Color.fromARGB(255, 50, 157, 245),
                ),
              )
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 231, 193, 238),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: currentTab == 0
              ? CreateComponent(
                  userid: widget.user!.id.toString(),
                )
              : currentTab == 1
                  ? ViewCreatedTask(
                      userId: widget.user!.id,
                    )
                  : currentTab == 2
                      ? AuthorizedIndividuals(
                          userId: widget.user!.id,
                        )
                      : currentTab == 3
                          ? Requests(
                              ownerInfo: widget.user,
                            )
                          : FindComponent(
                              userInfo: widget.user,
                            ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.security),
              label: 'Authorized',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.request_page_outlined),
              label: 'Request',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Find',
            ),
          ],
          currentIndex: currentTab,
          selectedItemColor: Colors.purple,
          unselectedItemColor: const Color.fromARGB(255, 68, 68, 68),
          showUnselectedLabels: true,
          onTap: (currentIndex) {
            setState(() {
              currentTab = currentIndex;
              switch (currentIndex) {
                case 0:
                  pageTitle = 'Create Task';
                  displayIcon = Icons.add_box_outlined;
                  break;
                case 1:
                  pageTitle = 'View Tasks';
                  displayIcon = Icons.task_outlined;
                  break;
                case 2:
                  pageTitle = 'Authorized Individuals';
                  displayIcon = Icons.security;
                  break;
                case 3:
                  pageTitle = 'Pending Approval';
                  displayIcon = Icons.request_page_outlined;
                  break;
                case 4:
                  pageTitle = 'Find Task By Individual';
                  displayIcon = Icons.search;
                  break;
                default:
              }
            });
          },
        ),
      ),
    );
  }
}
