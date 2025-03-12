import 'package:auto_enterprise/generated/google/protobuf/empty.pb.dart';
import 'package:auto_enterprise/generated/trip_service.pbgrpc.dart';
import 'package:grpc/grpc.dart' as grpc;
import "package:auto_enterprise/utils/data_address.dart" as data_address;

class DataProvider {
  late final TripsServiceClient client;
  final port = data_address.port;
  final localhost = data_address.host;

  DataProvider() {
    final channel = grpc.ClientChannel(
      localhost,
      port: port,
      options: const grpc.ChannelOptions(credentials: grpc.ChannelCredentials.insecure()),
    );
    client = TripsServiceClient(channel);
  }

  static List<String> getTypes() {
    List<String> res = [];
    for (var it in TripType.values) {
      res.add(it.name);
    }
    return res;
  }

  Future<List<Trip>> fetchFilteredTrips(TripFilter filter) async {
    final data = await client.getFilteredTrips(filter);
    return data.trips;
  }

  Future<Trip?> getTripById(int id) async {
    final res = await client.getFilteredTrips(TripFilter(ids: [id]));
    if (res.trips.isEmpty) {
      return null;
    } else {
      return res.trips[0];
    }
  }

  Future<void> createTrip(Trip trip) async {
    final data = await client.createTrip(trip, options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    trip.id = data.id;
  }

  Future<void> updateTrip(Trip trip) async {
    final data = await client.alterTrip(trip, options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
  }

  Future<List<Trip>> fetchTrips() async {
    final data = await client.getAllTrips(Empty(), options: grpc.CallOptions(timeout: const Duration(seconds: 3)));
    return data.trips;
    // List<Trip> res = [
    //   Trip(
    //     id: 1,
    //     routeId: 2,
    //     driverId: 2,
    //     transportId: 2,
    //     startTime: Timestamp.fromDateTime(DateTime(1)),
    //     endTime: Timestamp.fromDateTime(DateTime(1)),
    //     type: "cargo",
    //     cargo: TripInfoCargo(),
    //   ),
    //   Trip(
    //     id: 1,
    //     routeId: 2,
    //     driverId: 2,
    //     transportId: 2,
    //     startTime: Timestamp.fromDateTime(DateTime(1)),
    //     endTime: Timestamp.fromDateTime(DateTime(1)),
    //     type: "passenger",
    //     passengers: TripInfoPassenger(),
    //   ),
    // ];
    // return Future.delayed(Duration(milliseconds: 100), () => res);
  }
}
