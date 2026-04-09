import 'package:flutter/material.dart';

class CategoryModel {
  final IconData icon;
  final String title;

  CategoryModel({required this.icon, required this.title});
}

final List<CategoryModel> categories = [
  CategoryModel(icon: Icons.grid_view, title: "All"),
  CategoryModel(icon: Icons.checkroom, title: "Fashion"),
  CategoryModel(icon: Icons.devices, title: "Electronics"),
  CategoryModel(icon: Icons.chair, title: "Home"),
  CategoryModel(icon: Icons.local_grocery_store, title: "Grocery"),
  CategoryModel(icon: Icons.sports_esports, title: "Gaming"),
  CategoryModel(icon: Icons.watch, title: "Watches"),
  CategoryModel(icon: Icons.spa, title: "Beauty"),
  CategoryModel(icon: Icons.fitness_center, title: "Fitness"),
  CategoryModel(icon: Icons.restaurant, title: "Food"),
  CategoryModel(icon: Icons.pets, title: "Pets"),
  CategoryModel(icon: Icons.book, title: "Books"),
];
