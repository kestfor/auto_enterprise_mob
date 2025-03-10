//
//  Generated code. Do not modify.
//  source: report_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'report_service.pb.dart' as $0;

export 'report_service.pb.dart';

@$pb.GrpcServiceName('main.ReportService')
class ReportServiceClient extends $grpc.Client {
  static final _$getCarMileage = $grpc.ClientMethod<$0.CarMileageRequest, $0.CarMileageResponse>(
      '/main.ReportService/GetCarMileage',
      ($0.CarMileageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CarMileageResponse.fromBuffer(value));
  static final _$getRepairCost = $grpc.ClientMethod<$0.RepairCostRequest, $0.RepairCostResponse>(
      '/main.ReportService/GetRepairCost',
      ($0.RepairCostRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RepairCostResponse.fromBuffer(value));

  ReportServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.CarMileageResponse> getCarMileage($0.CarMileageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCarMileage, request, options: options);
  }

  $grpc.ResponseFuture<$0.RepairCostResponse> getRepairCost($0.RepairCostRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRepairCost, request, options: options);
  }
}

@$pb.GrpcServiceName('main.ReportService')
abstract class ReportServiceBase extends $grpc.Service {
  $core.String get $name => 'main.ReportService';

  ReportServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CarMileageRequest, $0.CarMileageResponse>(
        'GetCarMileage',
        getCarMileage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CarMileageRequest.fromBuffer(value),
        ($0.CarMileageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RepairCostRequest, $0.RepairCostResponse>(
        'GetRepairCost',
        getRepairCost_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RepairCostRequest.fromBuffer(value),
        ($0.RepairCostResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.CarMileageResponse> getCarMileage_Pre($grpc.ServiceCall call, $async.Future<$0.CarMileageRequest> request) async {
    return getCarMileage(call, await request);
  }

  $async.Future<$0.RepairCostResponse> getRepairCost_Pre($grpc.ServiceCall call, $async.Future<$0.RepairCostRequest> request) async {
    return getRepairCost(call, await request);
  }

  $async.Future<$0.CarMileageResponse> getCarMileage($grpc.ServiceCall call, $0.CarMileageRequest request);
  $async.Future<$0.RepairCostResponse> getRepairCost($grpc.ServiceCall call, $0.RepairCostRequest request);
}
