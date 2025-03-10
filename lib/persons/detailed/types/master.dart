import "package:auto_enterprise/persons/data_provider/data_provider.dart" as pp;
import 'package:auto_enterprise/persons/detailed/types/utils/utils.dart';
import 'package:auto_enterprise/persons/person_list.dart';
import 'package:auto_enterprise/utils/search_filters/filters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/person_service.pb.dart';
import '../../../utils/notifications/notification.dart';
import '../../../utils/searchable_list.dart';
import '../../../utils/utils.dart';

class EditableMaster extends StatefulWidget {
  final MasterInfo masterInfo;
  final Function() savePersonChanges;

  EditableMaster({super.key, required this.masterInfo, required this.savePersonChanges});

  @override
  _EditableMasterState createState() => _EditableMasterState();
}

class _EditableMasterState extends State<EditableMaster> {
  final pp.DataProvider personProvider = pp.DataProvider();

  MasterInfo get masterInfo => widget.masterInfo;

  @override
  void initState() {
    super.initState();
  }

  void saveChanges() {
    setState(() {
      widget.savePersonChanges();
    });
  }

  void selectManager(context, dataProvider, masterInfo) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    var error;
    List<Person> persons = [];

    try {
      persons = await dataProvider.fetchPersons();
    } catch (e) {
      error = e;
    }

    if (!context.mounted) return;

    Navigator.pop(context);

    if (error != null) {
      showError(context, error.toString());
      return;
    }

    persons = persons.where((element) => element.role == Role.manager.name).toList();

    Person? person = await Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(title: const Text('Select Person')),
          body: SearchableList<Person>(
            items: persons,
            listOfCardBuilder: (persons, additional) => PersonsListWidget(
                persons: persons,
                onSelected: (person) {
                  Navigator.pop(context, person);
                }),
            filterFunction: getFilteredPersons,
          ));
    }));
    if (person != null) {
      setState(() {
        widget.masterInfo.managerId = person.id;
      });
    }
  }

  Widget managerSelectorButton() {
    var id = widget.masterInfo.hasManagerId() ? widget.masterInfo.managerId.toString() : "null";
    return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () async {
            selectManager(context, personProvider, widget.masterInfo);
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text("Manager ID: $id", style: const TextStyle(fontSize: 16, color: Colors.black54)),
        ));
  }

  @override
  Widget build(context) {
    return Column(
      children: [
        managerSelectorButton(),
        const SizedBox(height: 16),
        saveButton(saveChanges)
      ],
    );
  }
}
