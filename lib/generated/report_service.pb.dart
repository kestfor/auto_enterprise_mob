//
//  Generated code. Do not modify.
//  source: report_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

class CarMileageRequest extends $pb.GeneratedMessage {
  factory CarMileageRequest({
    $core.String? category,
    $core.int? transportId,
    $1.Timestamp? dateFrom,
    $1.Timestamp? dateTo,
  }) {
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    if (transportId != null) {
      $result.transportId = transportId;
    }
    if (dateFrom != null) {
      $result.dateFrom = dateFrom;
    }
    if (dateTo != null) {
      $result.dateTo = dateTo;
    }
    return $result;
  }
  CarMileageRequest._() : super();
  factory CarMileageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CarMileageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CarMileageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'transportId', $pb.PbFieldType.O3, protoName: 'transportId')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'dateFrom', protoName: 'dateFrom', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'dateTo', protoName: 'dateTo', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CarMileageRequest clone() => CarMileageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CarMileageRequest copyWith(void Function(CarMileageRequest) updates) => super.copyWith((message) => updates(message as CarMileageRequest)) as CarMileageRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarMileageRequest create() => CarMileageRequest._();
  CarMileageRequest createEmptyInstance() => create();
  static $pb.PbList<CarMileageRequest> createRepeated() => $pb.PbList<CarMileageRequest>();
  @$core.pragma('dart2js:noInline')
  static CarMileageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CarMileageRequest>(create);
  static CarMileageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get transportId => $_getIZ(1);
  @$pb.TagNumber(2)
  set transportId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransportId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransportId() => clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get dateFrom => $_getN(2);
  @$pb.TagNumber(3)
  set dateFrom($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDateFrom() => $_has(2);
  @$pb.TagNumber(3)
  void clearDateFrom() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureDateFrom() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Timestamp get dateTo => $_getN(3);
  @$pb.TagNumber(4)
  set dateTo($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDateTo() => $_has(3);
  @$pb.TagNumber(4)
  void clearDateTo() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureDateTo() => $_ensure(3);
}

class RepairCostRequest extends $pb.GeneratedMessage {
  factory RepairCostRequest({
    $core.String? category,
    $core.int? transportId,
    $1.Timestamp? dateFrom,
    $1.Timestamp? dateTo,
    $core.String? brand,
  }) {
    final $result = create();
    if (category != null) {
      $result.category = category;
    }
    if (transportId != null) {
      $result.transportId = transportId;
    }
    if (dateFrom != null) {
      $result.dateFrom = dateFrom;
    }
    if (dateTo != null) {
      $result.dateTo = dateTo;
    }
    if (brand != null) {
      $result.brand = brand;
    }
    return $result;
  }
  RepairCostRequest._() : super();
  factory RepairCostRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepairCostRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepairCostRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'main'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'category')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'transportId', $pb.PbFieldType.O3, protoName: 'transportId')
    ..aOM<$1.Timestamp>(3, _omitFieldNames ? '' : 'dateFrom', protoName: 'dateFrom', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'dateTo', protoName: 'dateTo', subBuilder: $1.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'brand')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepairCostRequest clone() => RepairCostRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepairCostRequest copyWith(void Function(RepairCostRequest) updates) => super.copyWith((message) => updates(message as RepairCostRequest)) as RepairCostRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepairCostRequest create() => RepairCostRequest._();
  RepairCostRequest createEmptyInstance() => create();
  static $pb.PbList<RepairCostRequest> createRepeated() => $pb.PbList<RepairCostRequest>();
  @$core.pragma('dart2js:noInline')
  static RepairCostRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepairCostRequest>(create);
  static RepairCostRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get category => $_getSZ(0);
  @$pb.TagNumber(1)
  set category($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCategory() => $_has(0);
  @$pb.TagNumber(1)
  void clearCategory() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get transportId => $_getIZ(1);
  @$pb.TagNumber(2)
  set transportId($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransportId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransportId() => clearField(2);

  @$pb.TagNumber(3)
  $1.Timestamp get dateFrom => $_getN(2);
  @$pb.TagNumber(3)
  set dateFrom($1.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDateFrom() => $_has(2);
  @$pb.TagNumber(3)
  void clearDateFrom() => clearField(3);
  @$pb.TagNumber(3)
  $1.Timestamp ensureDateFrom() => $_ensure(2);

  @$pb.TagNumber(4)
  $1.Timestamp get dateTo => $_getN(3);
  @$pb.TagNumber(4)
  set dateTo($1.Timestamp v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDateTo() => $_has(3);
  @$pb.TagNumber(4)
  void clearDateTo() => clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureDateTo() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get brand => $_getSZ(4);
  @$pb.TagNumber(5)
  set brand($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBrand() => $_has(4);
  @$pb.TagNumber(5)
  void clearBrand() => clearField(5);
}

class CarMileageResponse extends $pb.GeneratedMessage {
  factory CarMileageResponse({
    $core.double? mileage,
  }) {
    final $result = create();
    if (mileage != null) {
      $result.mileage = mileage;
    }
    return $result;
  }
  CarMileageResponse._() : super();
  factory CarMileageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CarMileageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CarMileageResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'main'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'mileage', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CarMileageResponse clone() => CarMileageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CarMileageResponse copyWith(void Function(CarMileageResponse) updates) => super.copyWith((message) => updates(message as CarMileageResponse)) as CarMileageResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CarMileageResponse create() => CarMileageResponse._();
  CarMileageResponse createEmptyInstance() => create();
  static $pb.PbList<CarMileageResponse> createRepeated() => $pb.PbList<CarMileageResponse>();
  @$core.pragma('dart2js:noInline')
  static CarMileageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CarMileageResponse>(create);
  static CarMileageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get mileage => $_getN(0);
  @$pb.TagNumber(1)
  set mileage($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMileage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMileage() => clearField(1);
}

class RepairCostResponse extends $pb.GeneratedMessage {
  factory RepairCostResponse({
    $core.double? cost,
    $core.int? numOfRepairs,
  }) {
    final $result = create();
    if (cost != null) {
      $result.cost = cost;
    }
    if (numOfRepairs != null) {
      $result.numOfRepairs = numOfRepairs;
    }
    return $result;
  }
  RepairCostResponse._() : super();
  factory RepairCostResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RepairCostResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RepairCostResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'main'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'cost', $pb.PbFieldType.OF)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'numOfRepairs', $pb.PbFieldType.O3, protoName: 'numOfRepairs')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RepairCostResponse clone() => RepairCostResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RepairCostResponse copyWith(void Function(RepairCostResponse) updates) => super.copyWith((message) => updates(message as RepairCostResponse)) as RepairCostResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RepairCostResponse create() => RepairCostResponse._();
  RepairCostResponse createEmptyInstance() => create();
  static $pb.PbList<RepairCostResponse> createRepeated() => $pb.PbList<RepairCostResponse>();
  @$core.pragma('dart2js:noInline')
  static RepairCostResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RepairCostResponse>(create);
  static RepairCostResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get cost => $_getN(0);
  @$pb.TagNumber(1)
  set cost($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCost() => $_has(0);
  @$pb.TagNumber(1)
  void clearCost() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get numOfRepairs => $_getIZ(1);
  @$pb.TagNumber(2)
  set numOfRepairs($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNumOfRepairs() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumOfRepairs() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
