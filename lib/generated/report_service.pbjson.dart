//
//  Generated code. Do not modify.
//  source: report_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use carMileageRequestDescriptor instead')
const CarMileageRequest$json = {
  '1': 'CarMileageRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'category', '17': true},
    {'1': 'transportId', '3': 2, '4': 1, '5': 5, '9': 1, '10': 'transportId', '17': true},
    {'1': 'dateFrom', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'dateFrom'},
    {'1': 'dateTo', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'dateTo'},
  ],
  '8': [
    {'1': '_category'},
    {'1': '_transportId'},
  ],
};

/// Descriptor for `CarMileageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carMileageRequestDescriptor = $convert.base64Decode(
    'ChFDYXJNaWxlYWdlUmVxdWVzdBIfCghjYXRlZ29yeRgBIAEoCUgAUghjYXRlZ29yeYgBARIlCg'
    't0cmFuc3BvcnRJZBgCIAEoBUgBUgt0cmFuc3BvcnRJZIgBARI2CghkYXRlRnJvbRgDIAEoCzIa'
    'Lmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCGRhdGVGcm9tEjIKBmRhdGVUbxgEIAEoCzIaLm'
    'dvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBmRhdGVUb0ILCglfY2F0ZWdvcnlCDgoMX3RyYW5z'
    'cG9ydElk');

@$core.Deprecated('Use repairCostRequestDescriptor instead')
const RepairCostRequest$json = {
  '1': 'RepairCostRequest',
  '2': [
    {'1': 'category', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'category', '17': true},
    {'1': 'brand', '3': 5, '4': 1, '5': 9, '9': 1, '10': 'brand', '17': true},
    {'1': 'transportId', '3': 2, '4': 1, '5': 5, '9': 2, '10': 'transportId', '17': true},
    {'1': 'dateFrom', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'dateFrom'},
    {'1': 'dateTo', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'dateTo'},
  ],
  '8': [
    {'1': '_category'},
    {'1': '_brand'},
    {'1': '_transportId'},
  ],
};

/// Descriptor for `RepairCostRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repairCostRequestDescriptor = $convert.base64Decode(
    'ChFSZXBhaXJDb3N0UmVxdWVzdBIfCghjYXRlZ29yeRgBIAEoCUgAUghjYXRlZ29yeYgBARIZCg'
    'VicmFuZBgFIAEoCUgBUgVicmFuZIgBARIlCgt0cmFuc3BvcnRJZBgCIAEoBUgCUgt0cmFuc3Bv'
    'cnRJZIgBARI2CghkYXRlRnJvbRgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCG'
    'RhdGVGcm9tEjIKBmRhdGVUbxgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBmRh'
    'dGVUb0ILCglfY2F0ZWdvcnlCCAoGX2JyYW5kQg4KDF90cmFuc3BvcnRJZA==');

@$core.Deprecated('Use carMileageResponseDescriptor instead')
const CarMileageResponse$json = {
  '1': 'CarMileageResponse',
  '2': [
    {'1': 'mileage', '3': 1, '4': 1, '5': 2, '10': 'mileage'},
  ],
};

/// Descriptor for `CarMileageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List carMileageResponseDescriptor = $convert.base64Decode(
    'ChJDYXJNaWxlYWdlUmVzcG9uc2USGAoHbWlsZWFnZRgBIAEoAlIHbWlsZWFnZQ==');

@$core.Deprecated('Use repairCostResponseDescriptor instead')
const RepairCostResponse$json = {
  '1': 'RepairCostResponse',
  '2': [
    {'1': 'cost', '3': 1, '4': 1, '5': 2, '10': 'cost'},
    {'1': 'numOfRepairs', '3': 2, '4': 1, '5': 5, '10': 'numOfRepairs'},
  ],
};

/// Descriptor for `RepairCostResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List repairCostResponseDescriptor = $convert.base64Decode(
    'ChJSZXBhaXJDb3N0UmVzcG9uc2USEgoEY29zdBgBIAEoAlIEY29zdBIiCgxudW1PZlJlcGFpcn'
    'MYAiABKAVSDG51bU9mUmVwYWlycw==');

