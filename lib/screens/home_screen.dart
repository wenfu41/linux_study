import 'package:flutter/material.dart';
import 'command_list_screen.dart';
import 'common_commands_screen.dart';
import 'package_list_screen.dart';
import 'quiz_screen.dart';
import 'script_learning_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const CommandListScreen(),
    const CommonCommandsScreen(),
    const PackageListScreen(),
    const ScriptLearningScreen(),
    const QuizScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Linux 学习助手")),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "命令大全"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "常用分类"),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2), label: "软件包"),
          BottomNavigationBarItem(icon: Icon(Icons.code), label: "脚本学习"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "练习"),
        ],
        type: BottomNavigationBarType.fixed, // Ensure labels are always visible
      ),
    );
  }
}
