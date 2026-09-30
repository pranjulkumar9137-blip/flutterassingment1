import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'tasks_screen.dart';
import 'insights_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() =>
      _MainShellState();
}

class _MainShellState
    extends State<MainShell> {

  int index = 0;

  final screens = const [
    HomeScreen(),
    TasksScreen(),
    InsightsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: screens,
      ),

      bottomNavigationBar:
      NavigationBar(
        selectedIndex: index,

        onDestinationSelected:
            (value) {
          setState(() {
            index = value;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
            ),
            selectedIcon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.checklist_outlined,
            ),
            selectedIcon: Icon(
              Icons.checklist,
            ),
            label: 'Tasks',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.insights_outlined,
            ),
            selectedIcon: Icon(
              Icons.insights,
            ),
            label: 'Insights',
          ),
        ],
      ),
    );
  }
}