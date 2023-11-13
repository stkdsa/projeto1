import 'package:flutter/material.dart';


InputDecoration getAuthenticationInputDecoration(String label){
  return InputDecoration(
    label: Text(label),
    fillColor: Colors.white,
      filled: true,
  );
}