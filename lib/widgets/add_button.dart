import 'package:flutter/material.dart';
import 'add_record_sheet.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => AddRecordSheet.show(context),
      child: const Icon(Icons.add),
    );
  }
}
