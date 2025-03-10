import 'package:auto_enterprise/generated/google/protobuf/timestamp.pb.dart';
import 'package:auto_enterprise/transport/data_provider/data_provider.dart';
import 'package:auto_enterprise/utils/bottom_category_selector.dart';
import 'package:auto_enterprise/utils/date_picker.dart';
import 'package:auto_enterprise/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/transport_service.pb.dart';
import '../../../utils/selectors/selectors.dart';

class TransportOperationEditable extends StatefulWidget {
  late final TransportOperation operation;
  late final TransportOperation savedTransportOperation;

  TransportOperationEditable({TransportOperation? operation, super.key}) {
    if (operation == null) {
      this.operation = TransportOperation(type: TransportOperationType.purchase.name);
    } else {
      this.operation = operation;
    }
    savedTransportOperation = this.operation.clone();
  }

  @override
  TransportOperationEditableState createState() => TransportOperationEditableState();
}

class TransportOperationEditableState extends State<TransportOperationEditable> {
  final DataProvider dataProvider = DataProvider();
  late TextEditingController description =
      TextEditingController(text: widget.operation.hasDescription() ? widget.operation.description.toString() : "");

  late TextEditingController idController =
      TextEditingController(text: widget.operation.hasId() ? widget.operation.id.toString() : "null");

  late String type = widget.operation.type;
  late Timestamp? date = widget.operation.hasDate()? widget.operation.date : null;
  late int? transportId = widget.operation.hasTransportId() ? widget.operation.transportId : null;

  @override
  void initState() {
    super.initState();
  }

  void rollbackChanges() {
    widget.operation = widget.savedTransportOperation.clone();
    setState(() {});
  }

  void saveChanges() async {
    if (date != null) {
      widget.operation.date = date!;
    }

    if (transportId != null) {
      widget.operation.transportId = transportId!;
    }

    widget.operation.type = type;

    widget.operation.description = description.text;

    TransportOperation? newTransportOperation;
    bool saved = await saveChangesWrapper(context, () async {
      if (widget.operation.hasId()) {
        await dataProvider.updateTransportOperation(widget.operation);
      } else {
        await dataProvider.createTransportOperation(widget.operation);
        newTransportOperation = widget.operation;
      }
    });

    if (!saved) {
      return;
    }

    Navigator.pop(context, newTransportOperation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: "id",
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              ),
              enabled: false,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                transportSelectorButton(context, transportId, dataProvider, (Transport transport) {
                  setState(() {
                    transportId = transport.id;
                  });
                }),
                const SizedBox(width: 16),
                BottomDatePicker(
                    onPicked: (DateTime d) {
                      setState(() {
                        date = Timestamp.fromDateTime(d);
                      });
                    },
                    label: const Text("date"),
                    mode: CupertinoDatePickerMode.dateAndTime,
                    child: Text("${date?.toDateTime()}"))
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            BottomCategorySelector(
              categories: DataProvider.getOperationsTypes(),
              currentCategory: type,
              onTap: (String category) {
                setState(() {
                  type = category;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: description,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            saveButton(saveChanges)
          ],
        ),
      )),
    );
  }
}
