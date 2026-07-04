// lib/widgets/bottom_nav_bar.dart
import 'package:flutter/material.dart';
import '../config/theme.dart';

class BottomNavBar extends StatelessWidget {
  final String currentTab;
  final Function(String) onTabChanged;
  final String userRole;

  const BottomNavBar({
    required this.currentTab,
    required this.onTabChanged,
    required this.userRole,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientTabs = [
      {'id': 'home', 'icon': '🏠', 'label': 'Home'},
      {'id': 'post', 'icon': '➕', 'label': 'Post'},
      {'id': 'messages', 'icon': '💬', 'label': 'Messages'},
      {'id': 'profile', 'icon': '👤', 'label': 'Profile'},
    ];

    final workerTabs = [
      {'id': 'jobs', 'icon': '🔍', 'label': 'Find Jobs'},
      {'id': 'messages', 'icon': '💬', 'label': 'Messages'},
      {'id': 'profile', 'icon': '👤', 'label': 'Profile'},
    ];

    final tabs = userRole == 'worker' ? workerTabs : clientTabs;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: tabs.indexWhere((tab) => tab['id'] == currentTab),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.light,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) => onTabChanged(tabs[index]['id']!),
        items: tabs
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Text(
                  tab['icon']!,
                  style: const TextStyle(fontSize: 22),
                ),
                label: tab['label']!,
              ),
            )
            .toList(),
      ),
    );
  }
}
