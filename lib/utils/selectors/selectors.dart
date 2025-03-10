import 'package:auto_enterprise/routes/route_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../generated/person_service.pb.dart';
import '../../generated/transport_service.pb.dart';
import '../../generated/transport_service.pb.dart' as tts;
import '../../generated/trip_service.pb.dart' as ts;
import '../../persons/person_list.dart';
import '../../routes/route_card.dart';
import '../../transport//data_provider/data_provider.dart';
import '../../persons//data_provider/data_provider.dart' as pp;
import '../../transport/transport_list.dart';
import '../../utils/notifications/notification.dart';
import '../../utils/search_filters/filters.dart';
import '../../utils/searchable_list.dart';

Widget transportSelectorButton(BuildContext context, int? transportId, transportProvider, Function? onSelected) {
  var id = transportId ?? "null";
  return Expanded(
    child: OutlinedButton(
      onPressed: () {
        selectTransport(context, transportProvider, onSelected);
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text("Transport ID: $id", style: const TextStyle(fontSize: 16)),
    ),
  );
}

void selectTransport(context, dataProvider, Function? onSelected) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  var error;
  List<Transport> transports = [];

  try {
    transports = await dataProvider.fetchTransports();
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
            listOfCardBuilder: (List<Transport> transports, Function? additional) => TransportListWidget(
                  transports: transports,
                  onTransportSelected: (transport) {
                    Navigator.pop(context, transport);
                  },
                ),
            filterFunction: getFilteredTransports,
            categories: ["All"] + DataProvider.getTypes(),
            categoryFilterFunction: getTransportsByCategory));
  }));
  if (transport != null) {
    if (onSelected != null) {
      onSelected(transport);
    }
  }
}

Widget driverSelectorButton(
    BuildContext context, int? driverId, int? transportId, driverProvider, Function? onSelected) {
  var id = driverId ?? "null";
  return Expanded(
    child: OutlinedButton(
      onPressed: () {
        selectDriver(context, transportId, driverProvider, onSelected);
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text("Driver ID: $id", style: const TextStyle(fontSize: 16)),
    ),
  );
}

void selectDriver(
  context,
  transportId,
  dataProvider,
  Function? onSelected,
) async {
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

  persons = persons
      .where((element) => (element.role == Role.driver.name &&
          (transportId == null ||
              element.driverInfo.hasTransportId() && element.driverInfo.transportId == transportId)))
      .toList();

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
    if (onSelected != null) {
      onSelected(person);
    }
  }
}

void selectRoute(context, dataProvider, Function? onSelected) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  var error;
  List<tts.Route> routes = [];

  try {
    routes = await dataProvider.fetchRoutes();
  } catch (e) {
    error = e;
  }

  if (!context.mounted) return;

  Navigator.pop(context);

  if (error != null) {
    showError(context, error.toString());
    return;
  }

  tts.Route? route = await Navigator.push(context, CupertinoPageRoute(builder: (context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Select Route')),
        body: SearchableList<tts.Route>(
          items: routes,
          listOfCardBuilder: (persons, additional) => RouteListWidget(
              routes: persons,
              onRouteSelected: (route) {
                Navigator.pop(context, route);
              }),
          filterFunction: getFilteredRoutes,
        ));
  }));
  if (route != null) {
    if (onSelected != null) {
      onSelected(route);
    }
  }
}

Widget servicePersonnelSelectorButton(BuildContext context, int? id, dataProvider, Function? onSelected) {
  return Expanded(
    child: OutlinedButton(
      onPressed: () {
        selectServicePersonnel(context, dataProvider, onSelected);
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text("Worker ID: $id", style: const TextStyle(fontSize: 16)),
    ),
  );
}

void selectServicePersonnel(
  context,
  dataProvider,
  Function? onSelected,
) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );

  var error;
  List<Person> persons = [];

  try {
    persons = await dataProvider.fetchServicePersonnel();
  } catch (e) {
    error = e;
  }

  if (!context.mounted) return;

  Navigator.pop(context);

  if (error != null) {
    showError(context, error.toString());
    return;
  }

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
          categories: ["All"] + pp.DataProvider.getServicePersonnelRoles(),
          categoryFilterFunction: getPersonsByCategory,
        ));
  }));
  if (person != null) {
    if (onSelected != null) {
      onSelected(person);
    }
  }
}

