import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../notifications/notification.dart';
import '../searchable_list.dart';

class SelectButton<T> extends StatelessWidget {
  final String label;
  final Function? onSelected;
  final Function? onLongPress;
  final SearchableList<T> Function(List<T>) searchableListBuilder;
  final Future<List<T>> Function() fetchFunction;

  const SelectButton(
      {Key? key,
      required this.label,
      this.onSelected,
      this.onLongPress,
      required this.searchableListBuilder,
      required this.fetchFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        performSelect(context, fetchFunction, onSelected);
      },
      onLongPress: () {
        if (onLongPress != null) {
          onLongPress!();
        }
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }

  void performSelect(context, Future<List<T>> Function() fetchFunction, Function? onSelected) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    var error;
    List<T> data = [];

    try {
      data = await fetchFunction();
    } catch (e) {
      error = e;
    }

    if (!context.mounted) return;

    Navigator.pop(context);

    if (error != null) {
      showError(context, error.toString());
      return;
    }

    T? item = await Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Select Item')),
        body: searchableListBuilder(data),
      );
    }));
    if (item != null && onSelected != null) {
      onSelected(item);
    }
  }
}
