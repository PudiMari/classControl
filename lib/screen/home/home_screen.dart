
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../dashboard/dashboard_screen.dart';
import '../utils/first_page.dart';
import '../utils/second_page.dart';
import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(const FirstPageScreen());
    pageList.add(const SecondPageScreen());
    pageList.add(DashboardScreen());
    super.initState();
  }

  final PageStorageBucket bucket = PageStorageBucket();
  int _currentTab = 1;
  int views = 1;
  Widget currentScreen = const Home();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("ClassRoom Control App"),
          ),
          body: Column(
            children: [
              Expanded(
                child: PageStorage(
                  child: currentScreen,
                  bucket: bucket,
                ),
              )
            ],
          ),
          bottomNavigationBar: customBottomNavigationBar()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  customBottomNavigationBar() {
    return Container(
      height: 60,
      color: Colors.transparent,
      child: Container(
        //  height: 60,
        padding: const EdgeInsets.only(left: 12.0, top: 4.0),
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentTab = 1;
                  currentScreen = const Home();
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    'assets/icons/home.svg',
                    color: Colors.white,
                  ),
                  const Text(
                    'Home',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Container(
                    height: 3,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10.0),
                          right: Radius.circular(10.0),
                        ),
                        color: _currentTab == 1
                            ? Colors.white
                            : Colors.transparent),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentTab = 2;
                  currentScreen = Container();
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    'assets/icons/chat.svg',
                    color: Colors.white,
                  ),
                  const Text(
                    'Chat',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Container(
                    height: 3,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10.0),
                          right: Radius.circular(10.0),
                        ),
                        color: _currentTab == 2
                            ? Colors.white
                            : Colors.transparent),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentScreen = Container();
                  _currentTab = 3;
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    'assets/icons/camera.svg',
                    color: Colors.white,
                  ),
                  const Text(
                    'Sell',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Container(
                    height: 3,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10.0),
                          right: Radius.circular(10.0),
                        ),
                        color: _currentTab == 3
                            ? Colors.white
                            : Colors.transparent),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentTab = 4;
                  currentScreen = Container();
                });
                //Navigator.pushNamed(context, 'MyAds');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    'assets/icons/add.svg',
                    color: Colors.white,
                  ),
                  const Text(
                    'My ads',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Container(
                    height: 3,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10.0),
                          right: Radius.circular(10.0),
                        ),
                        color: _currentTab == 4
                            ? Colors.white
                            : Colors.transparent),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentTab = 5;
                  currentScreen = Container();
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    'assets/icons/profile.svg',
                    color: Colors.white,
                  ),
                  const Text(
                    'Account',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Container(
                    height: 3,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(10.0),
                          right: Radius.circular(10.0),
                        ),
                        color: _currentTab == 5
                            ? Colors.white
                            : Colors.transparent),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
