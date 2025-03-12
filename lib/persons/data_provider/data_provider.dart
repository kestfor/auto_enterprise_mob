import 'dart:developer';

import 'package:auto_enterprise/generated/google/protobuf/empty.pb.dart';
import 'package:auto_enterprise/generated/person_service.pbgrpc.dart';
import "package:auto_enterprise/utils/data_address.dart" as data_address;
import 'package:grpc/grpc.dart' as grpc;

class DataProvider {
  late final PersonServiceClient client;
  final port = data_address.port;
  final localhost = data_address.host;

  DataProvider() {
    final channel = grpc.ClientChannel(
      localhost,
      port: port,
      options: const grpc.ChannelOptions(credentials: grpc.ChannelCredentials.insecure()),
    );
    client = PersonServiceClient(channel);
  }

  static List<String> getRoles() {
    List<String> res = [];
    for (var element in Role.values) {
      res.add(element.toString());
    }
    res.sort();
    return res;
  }

  Future<Person?> getPersonById(int id) async {
    final res = await client.getFilteredPersons(PersonFilter(ids: [id]));
    if (res.persons.isEmpty) {
      return null;
    } else {
      return res.persons[0];
    }
  }

  Future<Brigade?> getBrigadeById(int id) async {
    final res = await client.getAllBrigades(Empty());
    for (var item in res.brigades) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  Future<RepairWork?> getRepairWorkById(int id) async {
    final res = await client.getFilteredRepairWorks(RepairWorkFilter(ids: [id]));
    if (res.repairWorks.isEmpty) {
      return null;
    } else {
      return res.repairWorks[0];
    }
  }

  Future<TransportUnit?> getUnitById(int id) async {
    final res = await client.getAllTransportUnits(Empty());
    for (var item in res.units) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  Future<void> updatePerson(Person person) async {
    await client.alterPerson(person);
  }

  Future<void> createPerson(Person person) async {
    final res = await client.createPerson(person);
    person.id = res.id;
  }

  Future<void> updateRepair(RepairWork repair) async {
    await client.alterRepairWork(repair);
  }

  Future<void> createRepair(RepairWork repair) async {
    final res = await client.createRepairWork(repair);
    repair.id = res.id;
  }

  Future<void> updateBrigade(Brigade brigade) async {
    await client.alterBrigade(brigade);
  }

  Future<void> createBrigade(Brigade brigade) async {
    final res = await client.createBrigade(brigade);
    brigade.id = res.id;
  }

  Future<void> updateTransportUnit(TransportUnit unit) async {
    await client.alterTransportUnit(unit);
  }

  Future<void> createTransportUnit(TransportUnit unit) async {
    final res = await client.createTransportUnit(unit);
    unit.id = res.id;
  }

  Future<List<Person>> fetchServicePersonnel() async {
    List<Role> serviceRoles = [Role.technician, Role.plumber, Role.welder, Role.assembler];
    final data = await client.getFilteredPersons(PersonFilter(roles: serviceRoles),
        options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.persons;
    // List<Person> res = [
    //   Person(id: 1, firstName: "Ivan", secondName: "Ivanov", role: "plumber", plumberInfo: PlumberInfo()),
    // ];
    // return Future.delayed(Duration(milliseconds: 300), () => res);
  }

  static List<String> getServicePersonnelRoles() {
    List<String> res = getRoles();
    var valuesToDelete = [Role.manager.name, Role.foreman.name, Role.master.name, Role.driver.name];
    res.removeWhere((element) => valuesToDelete.contains(element));
    return res;
  }

  Future<List<Person>> fetchDriversByTransportId(int transportId) async {
    final data = await client.getDriversByTransport(DriversRequest(transportId: transportId));
    return data.persons;
  }

  Future<List<Brigade>> fetchBrigades() async {
    final data = await client.getAllBrigades(Empty(), options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.brigades;
    // List<Brigade> res = [
    //   Brigade(id: 1, name: "Brigade 1"),
    //   Brigade(id: 2, name: "Brigade 2"),
    //   Brigade(id: 3, name: "Brigade 3"),
    // ];
    // return Future.delayed(Duration(milliseconds: 300), () => res);
  }

  Future<List<Person>> fetchPersonByBrigade(int brigadeId) async {
    final data = await client.getFilteredPersons(
        PersonFilter(roles: [Role.technician, Role.plumber, Role.welder, Role.assembler, Role.driver], brigadeId: brigadeId),
        options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.persons;

    // List<Person> res = [
    //   Person(
    //       id: 1, firstName: "Ivan", secondName: "Ivanov", role: "driver", driverInfo: DriverInfo(brigadeId: brigadeId)),
    //   Person(
    //       id: 2,
    //       firstName: "Alex",
    //       secondName: "Alexanov",
    //       role: "driver",
    //       driverInfo: DriverInfo(brigadeId: brigadeId))
    // ];
    // return Future.delayed(Duration(milliseconds: 300), () => res);
  }

  Future<List<Person>> fetchPersons() async {
    try {
      final response =
          await client.getAllPersons(Empty(), options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
      return response.persons;
    } catch (e) {
      if (e is grpc.GrpcError && e.message != null) {
        log(e.message!);
        return Future.error(e.message!);
      }
      return Future.error("An error occurred while fetching persons");
    }
    // List<Person> res = [
    //   Person(id: 1, firstName: "Ivan", secondName: "Ivanov", role: "driver", driverInfo: DriverInfo(transportId: 1)),
    //   Person(id: 2, firstName: "Ivan", secondName: "Ivanov", role: "foreman", foremanInfo: ForemanInfo()),
    //   Person(id: 3, firstName: "Ivan", secondName: "Ivanov", role: "master", masterInfo: MasterInfo()),
    //   Person(id: 4, firstName: "Ivan", secondName: "Ivanov", role: "manager", managerInfo: ManagerInfo()),
    //   Person(id: 5, firstName: "Ivan", secondName: "Ivanov", role: "driver", driverInfo: DriverInfo()),
    //   Person(id: 6, firstName: "Ivan", secondName: "Ivanov", role: "driver", driverInfo: DriverInfo()),
    // ];
    // return Future.delayed(Duration(seconds: 1), () => res);
  }

  Future<List<TransportUnit>> fetchTransportUnits() async {
    final data =
        await client.getAllTransportUnits(Empty(), options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.units;
    // List<TransportUnit> res = [
    //   TransportUnit(id: 1, name: "Unit 1", type: "motor", description: "motor unit"),
    //   TransportUnit(id: 2, name: "Unit 2", type: "seat", description: "seat unit"),
    //   TransportUnit(id: 3, name: "Unit 3", type: "wheel", description: "wheel unit"),
    // ];
    // return Future.delayed(Duration(milliseconds: 300), () => res);
  }

  Future<List<RepairWork>> getRepairs() async {
    final data =
        await client.getAllRepairWorks(Empty(), options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.repairWorks;
    // List<RepairWork> res = [
    //   RepairWork(id: 1, transportId: 1, servicePersonnelId: 1, state: RepairState.in_progress.name),
    //   RepairWork(id: 2, transportId: 2, servicePersonnelId: 2, state: RepairState.completed.name),
    //   RepairWork(id: 3, transportId: 4, servicePersonnelId: 5, state: RepairState.not_started.name),
    // ];
    // return Future.delayed(Duration(milliseconds: 200), () => res);
  }

  Future<List<RepairWork>> getFilteredRepairs(RepairWorkFilter filter) async {
    final data = await client.getFilteredRepairWorks(filter, options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.repairWorks;
  }

  static List<String> getRepairStates() {
    List<String> res = [];
    for (var it in RepairState.values) {
      res.add(it.name);
    }
    return res;
  }
}
