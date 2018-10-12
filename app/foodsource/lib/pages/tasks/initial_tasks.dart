import 'package:foodsource/pages/tasks/task.dart';
import 'package:flutter/material.dart';


List<Task> tasks = [
  new Task(
      name: "Granny Smith Apples",
      category: "For Sale R20/Kg",
      time: "5pm",
      color: Colors.red,
      completed: false),
  new Task(
      name: "Pink Lady Apples",
      category: "Donation",
      time: "7pm",
      color: Colors.pink,
      completed: true),
  new Task(
      name: "Golden Delicious",
      category: "For Sale R21/Kg",
      time: "9pm",
      color: Colors.orange,
      completed: false),
  new Task(
      name: "Royal Gala",
      category: "For Sale R30/Kg",
      time: "12pm",
      color: Colors.green,
      completed: true),
  new Task(
      name: "Top Red",
      category: "Donation",
      time: "12pm",
      color: Colors.green,
      completed: true),
];