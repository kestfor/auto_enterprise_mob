import 'package:auto_enterprise/generated/google/protobuf/empty.pb.dart';
import 'package:auto_enterprise/generated/transport_service.pbgrpc.dart';
import "package:auto_enterprise/utils/data_address.dart" as data_address;
import 'package:grpc/grpc.dart' as grpc;

class DataProvider {
  late final TransportServiceClient client;
  final port = data_address.port;
  final localhost = data_address.host;

  DataProvider() {
    final channel = grpc.ClientChannel(
      localhost,
      port: port,
      options: const grpc.ChannelOptions(credentials: grpc.ChannelCredentials.insecure()),
    );
    client = TransportServiceClient(channel);
  }

  static List<String> getOperationsTypes() {
    return ["sale", "purchase", "write-off"];
  }

  Future<Transport?> getTransportById(int id) async {
    final res = await client.getFilteredTransport(TransportFilter(ids: [id]));
    if (res.transports.isEmpty) {
      return null;
    } else {
      return res.transports[0];
    }
  }

  Future<GarageFacility?> getGarageById(int id) async {
    final res = await client.getAllGarages(Empty());
    for (var item in res.garages) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  Future<TransportOperation?> getTransportOperationById(int id) async {
    final res = await client.getFilteredOperations(OperationFilter(ids: [id]));
    if (res.operations.isEmpty) {
      return null;
    } else {
      return res.operations[0];
    }
  }

  Future<Route?> getRouteById(int id) async {
    final res = await client.getAllRoutes(Empty());
    for (var item in res.routes) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }


  Future<List<TransportOperation>> fetchTransportOperations({OperationFilter? filter}) async {
    if (filter != null) {
      return (await client.getFilteredOperations(filter,
              options: grpc.CallOptions(timeout: const Duration(seconds: 3))))
          .operations;
    } else {
      return (await client.getAllOperations(Empty(), options: grpc.CallOptions(timeout: const Duration(seconds: 3))))
          .operations;
    }
  }

  Future<void> createGarage(GarageFacility garage) async {
    final res = await client.createGarage(garage);
    garage.id = res.id;
  }

  Future<void> updateGarage(GarageFacility garage) async {
    await client.alterGarage(garage);
  }

  Future<void> createTransport(Transport transport) async {
    final res = await client.createTransport(transport);
    transport.id = res.id;
  }

  Future<void> updateTransport(Transport transport) async {
    await client.alterTransport(transport);
  }

  Future<void> createRoute(Route route) async {
    final res = await client.createRoute(route);
    route.id = res.id;
  }

  Future<void> updateRoute(Route route) async {
    await client.alterRoute(route);
  }

  Future<void> addTransportsToRoute(List<int> transports, int routeId) async {
    await client.addTransportToRoute(ModifyRouteRequest(transportId: transports, id: routeId));
  }

  Future<void> updateTransportOperation(TransportOperation operation) async {
    await client.alterOperation(operation);
  }

  Future<void> createTransportOperation(TransportOperation operation) async {
    final res = await client.createOperation(operation);
    operation.id = res.id;
  }

  static List<String> getTypes() {
    List<String> res = [];

    for (var element in TransportType.values) {
      res.add(element.toString());
    }
    res.sort();
    return res;
  }

  Future<List<Transport>> fetchTransportsByGarageId(int garageId) async {
    final data = await client.getFilteredTransport(TransportFilter(garageFacilityId: garageId),
        options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.transports;
    // List<Transport> res = [
    //   Transport(id: 1, name: "k8", licensePlate: "A000AA", type: "bus", brand: "audi", garageFacilityId: garageId),
    //   Transport(id: 2, name: "k8", licensePlate: "A000AA", type: "taxi", brand: "audi", garageFacilityId: garageId)
    // ];
    // return Future.delayed(Duration(milliseconds: 300), () => res);
  }

  Future<List<Transport>> fetchTransports() async {
    // try {
    //   final response =
    //       await client.getAllPersons(Empty(), options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    //   return response.persons;
    // } catch (e) {
    //   if (e is grpc.GrpcError && e.message != null) {
    //     log(e.message!);
    //     return Future.error(e.message!);
    //   }
    //   return Future.error("An error occurred while fetching persons");
    // }
    // List<Transport> res = [
    //   Transport(id: 1, name: "k8", licensePlate: "A000AA", type: "bus", brand: "audi"),
    //   Transport(id: 2, name: "k8", licensePlate: "A000AA", type: "taxi", brand: "audi"),
    //   Transport(id: 3, name: "k8", licensePlate: "A000AA", type: "truck", brand: "audi"),
    //   Transport(id: 4, name: "k8", licensePlate: "A000AA", type: "bus", brand: "audi"),
    //   Transport(id: 5, name: "k8", licensePlate: "A000AA", type: "bus", brand: "audi"),
    //   Transport(id: 6, name: "k8", licensePlate: "A000AA", type: "bus", brand: "audi"),
    // ];
    // return res;
    final data = await client.getAllTransports(Empty(), options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.transports;
  }

  Future<List<Transport>> fetchTransportByRoute(int routeId) async {
    final data = await client.getFilteredTransport(TransportFilter(routeId: routeId),
        options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.transports;
    // List<Transport> res = [
    //   Transport(id: 1, name: "k8", licensePlate: "A000AA", type: "bus", brand: "audi"),
    //   Transport(id: 2, name: "k8", licensePlate: "A000AA", type: "taxi", brand: "audi")
    // ];
    // return Future.delayed(Duration(milliseconds: 300), () => res);
  }

  Future<List<GarageFacility>> fetchGarages() async {
    final data = await client.getAllGarages(Empty(), options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.garages;
    // List<GarageFacility> res = [
    //   GarageFacility(
    //       id: 1, name: "Новосибирск 1", address: "улица российская", type: GarageFacilityType.detached_garage.name),
    //   GarageFacility(
    //       id: 2, name: "Самара 2", address: "улица московская", type: GarageFacilityType.attached_garage.name),
    //   GarageFacility(id: 2, name: "Самара 3", address: "улица кривая", type: GarageFacilityType.carport.name),
    // ];
    // return Future.delayed(Duration(milliseconds: 300), () => res);
  }

  static List<String> getGarageTypes() {
    List<String> res = [];

    for (var element in GarageFacilityType.values) {
      res.add(element.toString());
    }
    res.sort();
    return res;
  }

  Future<List<Route>> fetchRoutes() async {
    final data = await client.getAllRoutes(Empty(), options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.routes;
    // List<Route> res = [
    //   Route(id: 1, name: "route1"),
    //   Route(id: 2, name: "route2"),
    // ];
    // return Future.delayed(Duration(milliseconds: 100), () => res);
  }

  Future<Route?> getRouteByTransportId(int transportId) async {
    final data = await client.getRouteByTransportId(GetRouteByTransportIdRequest(transportId: transportId),
        options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    if (data.hasId()) {
      return data;
    } else {
      return null;
    }
  }
}
