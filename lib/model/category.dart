import 'package:flutter/material.dart';

enum Categories {
  dairy,
  fruits,
  frozenFoods,
  vegetables,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}

class Category {
  final String title;
  final Color color;
  final String? imageCategory;

  const Category({required this.title, required this.color, this.imageCategory});
}