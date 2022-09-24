import 'package:api/models/cart_model.dart';
import 'package:api/pages/details.dart';
import 'package:api/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MaterialApp(
        home: Main(),
      )));
}
