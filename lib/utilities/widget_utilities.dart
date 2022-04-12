import 'package:flutter/material.dart';



Widget loading() {
  return const Center(
    child: SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(),
    ),
  );
}

