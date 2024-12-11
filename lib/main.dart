import 'package:flutter/material.dart';
import 'package:user_list/core/setup_locater.dart';
import 'package:user_list/user_list.dart';

void main() {
  setupLocater();
  runApp(
    const UserList(),
  );
}
