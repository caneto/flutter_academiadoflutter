
import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static FormFieldValidator compate(TextEditingController? valueEC, String message) {
    return (value) {
      final valueCompare = valueEC?.text ?? '';
      if(value == null || value != null && value != valueCompare) {
        return message;
      } 
    }; 
  }
  
}