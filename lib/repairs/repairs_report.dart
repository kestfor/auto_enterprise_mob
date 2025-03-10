import 'package:auto_enterprise/generated/google/protobuf/timestamp.pb.dart';
import 'package:auto_enterprise/generated/report_service.pb.dart';
import 'package:auto_enterprise/generated/transport_service.pb.dart';
import 'package:auto_enterprise/persons/detailed/types/utils/utils.dart';
import 'package:auto_enterprise/report_service/report_service.dart';
import 'package:auto_enterprise/transport/data_provider/data_provider.dart';
import 'package:auto_enterprise/transport/transport_list.dart';
import 'package:auto_enterprise/utils/bottom_category_selector.dart';
import 'package:auto_enterprise/utils/notifications/notification.dart';
import 'package:auto_enterprise/utils/search_filters/filters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/date_picker.dart';
import '../utils/searchable_list.dart';
import '../utils/selectors/select_button.dart';

class RepairsReport extends StatefulWidget {
  const RepairsReport({super.key});

  @override
  RepairsReportState createState() => RepairsReportState();
}

class RepairsReportState extends State<RepairsReport> {
  final DataProvider dataProvider = DataProvider();
  final ReportsProvider reportsProvider = ReportsProvider();

  TextEditingController brand = TextEditingController();

  List<String> categories = ["null"] + DataProvider.getTypes();
  String category = "null";
  int? transportId;
  Timestamp? dateFrom;
  Timestamp? dateTo;

  SearchableList<Transport> transportListBuilder(List<Transport> tr) {
    return SearchableList<Transport>(
        items: tr,
        filterFunction: getFilteredTransports,
        listOfCardBuilder: (tr, additional) => Expanded(
            child: TransportListWidget(
                transports: tr,
                onTransportSelected: (transport) {
                  setState(() {
                    transportId = transport.id;
                    category = "null";
                    Navigator.pop(context);
                  });
                })));
  }

  void fetchReport() async {
    if (dateFrom == null || dateTo == null) {
      showError(context, "Please select date from and date to");
      return;
    }

    RepairCostRequest req = RepairCostRequest(dateFrom: dateFrom, dateTo: dateTo);

    bool flag = false;
    if (category != "null") {
      req.category = category;
      flag = true;
    }
    if (transportId != null) {
      req.transportId = transportId!;
      flag = true;
    }

    if (brand.text != "") {
      req.brand = brand.text;
      flag = true;
    }

    if (!flag) {
      showError(context, "Please select at least one filter");
      return;
    }

    print(req);

    RepairCostResponse response;
    try {
      response = await reportsProvider.fetchRepairCost(req);
    } catch (e) {
      showError(context, e.toString());
      return;
    }

    if (!context.mounted) {
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    Navigator.pop(context);

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Report result"),
              content: Text("total repairs: ${response.numOfRepairs}\ncost: ${response.cost}"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Закрыть диалог
                  },
                  child: const Text("OK"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Car Repairs Report"),
        ),
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BottomCategorySelector(
                  label: Text("category"),
                  categories: categories,
                  onTap: (c) {
                    setState(() {
                      category = c;
                      transportId = null;
                    });
                  },
                  currentCategory: category),
              SizedBox(
                height: 16,
              ),
              defaultTextField(brand, "brand", expanded: false),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: double.infinity,
                  child: SelectButton<Transport>(
                    label: 'Transport ID: ${transportId}',
                    searchableListBuilder: transportListBuilder,
                    fetchFunction: dataProvider.fetchTransports,
                    onSelected: (Transport t) {
                      setState(() {
                        transportId = t.id;
                        category = "null";
                      });
                    },
                  )),
              SizedBox(
                height: 16,
              ),
              Row(children: [
                BottomDatePicker(
                    label: const Text("date from"),
                    mode: CupertinoDatePickerMode.dateAndTime,
                    child: Text(dateFrom == null ? "null" : dateFrom!.toDateTime().toString()),
                    onPicked: (date) {
                      setState(() {
                        dateFrom = Timestamp.fromDateTime(date);
                      });
                    }),
                const SizedBox(width: 16),
                BottomDatePicker(
                    label: const Text("date to"),
                    mode: CupertinoDatePickerMode.dateAndTime,
                    child: Text(dateTo == null ? "null" : dateTo!.toDateTime().toString()),
                    onPicked: (date) {
                      setState(() {
                        dateTo = Timestamp.fromDateTime(date);
                      });
                    }),
              ]),
              SizedBox(
                height: 16,
              ),
              OutlinedButton(onPressed: fetchReport, child: Text("Fetch report"))
            ],
          ),
        )));
  }
}
