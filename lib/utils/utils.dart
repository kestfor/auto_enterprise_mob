import 'package:flutter/material.dart';

import 'notifications/notification.dart';
import "package:grpc/grpc.dart" as grpc;

String formatType(String type) {
  return type.replaceAll("_", " ");
}

String reverseFormatType(String type) {
  return type.replaceAll(" ", "_");
}

String getFormatedDate(DateTime date) {
  return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}

String getFormatedDateTime(DateTime date) {
  return "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}:${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
}

Future<bool> saveChangesWrapper(context, Function saveChanges) async {
  try {
    await saveChanges();
    showSuccess(context, "Changes saved");
    return true;
  } on grpc.GrpcError catch (e) {
    showError(context, e.toString());
  } catch (e) {
    showError(context, "unexpected error");
  }
  return false;
}

Widget saveButton(Function onPressed) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.green, // Цвет темы для кнопки
        foregroundColor: Colors.white, // Цвет текста на кнопке
      ),
      child: const Text(
        "Save Changes",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}