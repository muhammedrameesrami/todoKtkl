import 'package:flutter/material.dart';

List<Map<String,dynamic>>categories=[{'icon': Icons.add_circle, 'name': '', 'details': 0}];

final List<Map<String, dynamic>> categorilist = [
    {'icon': Icons.add_circle, 'name': '', 'details': 0},
    {'icon': Icons.star, 'name': 'Star', 'details': 5},
    {'icon': Icons.favorite, 'name': 'Favorite', 'details': 12},
    {'icon': Icons.person, 'name': 'Person', 'details': 8},
    {'icon': Icons.settings, 'name': 'Settings', 'details': 3},
    {'icon': Icons.notifications, 'name': 'Notifications', 'details': 7},
    {'icon': Icons.search, 'name': 'Search', 'details': 15},
    {'icon': Icons.info, 'name': 'Info', 'details': 4},
  ];

   final List<IconData> iconList = [
    Icons.star,
    Icons.favorite,
    Icons.person,
    Icons.settings,
    Icons.notifications,
    Icons.search,
    Icons.info,
  ];
  final List<String> iconNames = [
  'star',
  'favorite',
  'person',
  'settings',
  'notifications',
  'search',
  'info',
  'alarm',
  'calendar',
  'home',
  'shopping_cart',
  'camera',
  'chat',
  'email',
  'music',
  'thumb_up',
  // Add other icon names here
];

final List<IconData> iconlist = [
  Icons.star,
  Icons.favorite,
  Icons.person,
  Icons.settings,
  Icons.notifications,
  Icons.search,
  Icons.info,
  Icons.alarm,
  Icons.calendar_today,
  Icons.home,
  Icons.shopping_cart,
  Icons.camera_alt,
  Icons.chat,
  Icons.email,
  Icons.music_note,
  Icons.thumb_up,
  // Add corresponding IconData objects here
];


 void addCategory({
  required String title,
  required IconData categoryIcon,
  required String task,
}) {
  categories.add({
   'name': title,
      'icon': categoryIcon,
      'details': int.tryParse(task) ?? 0,
  });
  print(categories);
}