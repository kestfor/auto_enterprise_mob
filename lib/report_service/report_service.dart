import 'package:auto_enterprise/generated/report_service.pbgrpc.dart';
import "package:auto_enterprise/utils/data_address.dart" as data_address;
import 'package:grpc/grpc.dart' as grpc;

class ReportsProvider {
  late final ReportServiceClient client;
  final port = data_address.port;
  final localhost = data_address.host;

  ReportsProvider() {
    final channel = grpc.ClientChannel(
      localhost,
      port: port,
      options: const grpc.ChannelOptions(credentials: grpc.ChannelCredentials.insecure()),
    );
    client = ReportServiceClient(channel);
  }

  Future<CarMileageResponse> fetchCarMileage(CarMileageRequest request) async {
    return await client.getCarMileage(request);
  }

  Future<RepairCostResponse> fetchRepairCost(RepairCostRequest request) async {
    return await client.getRepairCost(request);
  }

}