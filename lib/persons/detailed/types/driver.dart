import "package:auto_enterprise/persons/data_provider/data_provider.dart" as pp;
import 'package:auto_enterprise/transport/data_provider/data_provider.dart';
import 'package:auto_enterprise/utils/detailed_mapper.dart';
import 'package:auto_enterprise/utils/notifications/notification.dart';
import 'package:auto_enterprise/utils/search_filters/filters.dart';
import 'package:auto_enterprise/utils/searchable_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/person_service.pb.dart';
import '../../../generated/transport_service.pb.dart';
import '../../../transport/transport_list.dart';
import '../../../utils/utils.dart';
import '../../brigade/brigade_list.dart';

class EditableDriver extends StatefulWidget {
  final DriverInfo driverInfo;
  final VoidCallback savePersonChanges;

  const EditableDriver({super.key, required this.driverInfo, required this.savePersonChanges});

  @override
  _EditableDriverState createState() => _EditableDriverState();
}

class _EditableDriverState extends State<EditableDriver> {
  final DataProvider transportProvider = DataProvider();
  final pp.DataProvider personProvider = pp.DataProvider();

  @override
  void initState() {
    super.initState();
  }

  void saveChanges() {
    setState(() {
      widget.savePersonChanges();
    });
  }

  Widget getTransportCardFunction(List<Transport> transports, Function? additional) {
    return TransportListWidget(
      transports: transports,
      onTransportSelected: (transport) {
        Navigator.pop(context, transport);
      },
    );
  }

  Widget getBrigadeCardFunction(List<Brigade> brigades, Function? additional) {
    return BrigadesListWidget(
        brigades: brigades,
        onSelected: (brigade) {
          Navigator.pop(context, brigade);
        });
  }

  Widget transportSelectorButton() {
    var id = widget.driverInfo.hasTransportId() ? widget.driverInfo.transportId.toString() : "null";
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          selectTransport(context, transportProvider, widget.driverInfo);
        },
        onLongPress: () {
          pushDetailedRoute<Transport>(context, widget.driverInfo.transportId);
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text("Transport ID: $id", style: const TextStyle(fontSize: 16, color: Colors.black54)),
      ),
    );
  }

  void selectBrigade(context, dataProvider, driverInfo) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    var error;
    List<Brigade> brigades = [];

    try {
      brigades = await dataProvider.fetchBrigades();
    } catch (e) {
      error = e;
    }

    if (!context.mounted) return;

    Navigator.pop(context);

    if (error != null) {
      showError(context, error.toString());
      return;
    }

    Brigade? brigade = await Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(title: const Text('Select Brigade')),
          body: SearchableList<Brigade>(
              items: brigades, listOfCardBuilder: getBrigadeCardFunction, filterFunction: getFilteredBrigades));
    }));
    if (brigade != null) {
      setState(() {
        driverInfo.brigadeId = brigade.id;
      });
    }
  }

  void selectTransport(context, dataProvider, driverInfo) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    var error;
    List<Transport> transports = [];

    try {
      transports = await transportProvider.fetchTransports();
    } catch (e) {
      error = e;
    }

    if (!context.mounted) return;

    Navigator.pop(context);

    if (error != null) {
      showError(context, error.toString());
      return;
    }

    Transport? transport = await Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return Scaffold(
          appBar: AppBar(title: const Text('Select Transport')),
          body: SearchableList<Transport>(
              items: transports,
              listOfCardBuilder: getTransportCardFunction,
              filterFunction: getFilteredTransports,
              categories: DataProvider.getTypes(),
              categoryFilterFunction: getTransportsByCategory));
    }));
    if (transport != null) {
      setState(() {
        driverInfo.transportId = transport.id;
      });
    }
  }

  Widget brigadeSelectorButton() {
    var id = widget.driverInfo.hasBrigadeId() ? widget.driverInfo.brigadeId.toString() : "null";
    return Expanded(
        child: OutlinedButton(
      onPressed: () async {
        selectBrigade(context, personProvider, widget.driverInfo);
      },
      onLongPress: () {
        pushDetailedRoute<Brigade>(context, widget.driverInfo.brigadeId);
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text("Brigade ID: $id", style: const TextStyle(fontSize: 16, color: Colors.black54)),
    ));
  }

  Widget transportAndBrigadeSelectors() {
    return Row(
      children: [transportSelectorButton(), const SizedBox(width: 10), brigadeSelectorButton()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [transportAndBrigadeSelectors(), const SizedBox(height: 16), saveButton(saveChanges)]);
  }
}
