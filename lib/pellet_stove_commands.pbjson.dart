// This is a generated file - do not edit.
//
// Generated from pellet_stove_commands.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use ignitionMethodDescriptor instead')
const IgnitionMethod$json = {
  '1': 'IgnitionMethod',
  '2': [
    {'1': 'SHUT_DOWN', '2': 0},
    {'1': 'AUTOMATIC', '2': 1},
    {'1': 'DISABLED', '2': 2},
  ],
};

/// Descriptor for `IgnitionMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List ignitionMethodDescriptor = $convert.base64Decode(
    'Cg5JZ25pdGlvbk1ldGhvZBINCglTSFVUX0RPV04QABINCglBVVRPTUFUSUMQARIMCghESVNBQk'
    'xFRBAC');

@$core.Deprecated('Use igniterStateDescriptor instead')
const IgniterState$json = {
  '1': 'IgniterState',
  '2': [
    {'1': 'ACTIVE', '2': 0},
    {'1': 'INACTIVE', '2': 1},
    {'1': 'IN_TRANSITION', '2': 2},
  ],
};

/// Descriptor for `IgniterState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List igniterStateDescriptor = $convert.base64Decode(
    'CgxJZ25pdGVyU3RhdGUSCgoGQUNUSVZFEAASDAoISU5BQ1RJVkUQARIRCg1JTl9UUkFOU0lUSU'
    '9OEAI=');

@$core.Deprecated('Use burnModeDescriptor instead')
const BurnMode$json = {
  '1': 'BurnMode',
  '2': [
    {'1': 'ROOM_SENSING', '2': 0},
    {'1': 'CONSTANT_BURN_SENSING', '2': 1},
  ],
};

/// Descriptor for `BurnMode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List burnModeDescriptor = $convert.base64Decode(
    'CghCdXJuTW9kZRIQCgxST09NX1NFTlNJTkcQABIZChVDT05TVEFOVF9CVVJOX1NFTlNJTkcQAQ'
    '==');

@$core.Deprecated('Use fanSpeedDescriptor instead')
const FanSpeed$json = {
  '1': 'FanSpeed',
  '2': [
    {'1': 'FAN_SPEED_LOW', '2': 0},
    {'1': 'FAN_SPEED_MEDIUM', '2': 1},
    {'1': 'FAN_SPEED_HIGH', '2': 2},
    {'1': 'FAN_SPEED_MAX', '2': 3},
  ],
};

/// Descriptor for `FanSpeed`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List fanSpeedDescriptor = $convert.base64Decode(
    'CghGYW5TcGVlZBIRCg1GQU5fU1BFRURfTE9XEAASFAoQRkFOX1NQRUVEX01FRElVTRABEhIKDk'
    'ZBTl9TUEVFRF9ISUdIEAISEQoNRkFOX1NQRUVEX01BWBAD');

@$core.Deprecated('Use cleaningPromptDescriptor instead')
const CleaningPrompt$json = {
  '1': 'CleaningPrompt',
  '2': [
    {'1': 'BURN_POT', '2': 0},
    {'1': 'ASH_PAN', '2': 1},
    {'1': 'TOTAL_CLEAN', '2': 2},
  ],
};

/// Descriptor for `CleaningPrompt`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List cleaningPromptDescriptor = $convert.base64Decode(
    'Cg5DbGVhbmluZ1Byb21wdBIMCghCVVJOX1BPVBAAEgsKB0FTSF9QQU4QARIPCgtUT1RBTF9DTE'
    'VBThAC');

@$core.Deprecated('Use illuminationBrightnessDescriptor instead')
const IlluminationBrightness$json = {
  '1': 'IlluminationBrightness',
  '2': [
    {'1': 'BRIGHTNESS_LOW', '2': 0},
    {'1': 'BRIGHTNESS_MEDIUM', '2': 1},
    {'1': 'BRIGHTNESS_HIGH', '2': 2},
  ],
};

/// Descriptor for `IlluminationBrightness`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List illuminationBrightnessDescriptor =
    $convert.base64Decode(
        'ChZJbGx1bWluYXRpb25CcmlnaHRuZXNzEhIKDkJSSUdIVE5FU1NfTE9XEAASFQoRQlJJR0hUTk'
        'VTU19NRURJVU0QARITCg9CUklHSFRORVNTX0hJR0gQAg==');

@$core.Deprecated('Use illuminationColorDescriptor instead')
const IlluminationColor$json = {
  '1': 'IlluminationColor',
  '2': [
    {'1': 'BLUE', '2': 0},
    {'1': 'GREEN', '2': 1},
    {'1': 'RED', '2': 2},
    {'1': 'WHITE', '2': 3},
  ],
};

/// Descriptor for `IlluminationColor`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List illuminationColorDescriptor = $convert.base64Decode(
    'ChFJbGx1bWluYXRpb25Db2xvchIICgRCTFVFEAASCQoFR1JFRU4QARIHCgNSRUQQAhIJCgVXSE'
    'lURRAD');

@$core.Deprecated('Use visualFXDescriptor instead')
const VisualFX$json = {
  '1': 'VisualFX',
  '2': [
    {'1': 'FX_NONE', '2': 0},
  ],
};

/// Descriptor for `VisualFX`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List visualFXDescriptor =
    $convert.base64Decode('CghWaXN1YWxGWBILCgdGWF9OT05FEAA=');

@$core.Deprecated('Use rangeDescriptor instead')
const Range$json = {
  '1': 'Range',
  '2': [
    {'1': 'minimum', '3': 1, '4': 1, '5': 17, '10': 'minimum'},
    {'1': 'maximum', '3': 2, '4': 1, '5': 17, '10': 'maximum'},
  ],
};

/// Descriptor for `Range`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rangeDescriptor = $convert.base64Decode(
    'CgVSYW5nZRIYCgdtaW5pbXVtGAEgASgRUgdtaW5pbXVtEhgKB21heGltdW0YAiABKBFSB21heG'
    'ltdW0=');

@$core.Deprecated('Use ignitionSettingsDescriptor instead')
const IgnitionSettings$json = {
  '1': 'IgnitionSettings',
  '2': [
    {
      '1': 'ignition_method',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.pelletstove.IgnitionMethod',
      '10': 'ignitionMethod'
    },
    {
      '1': 'ignater_state',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.pelletstove.IgniterState',
      '10': 'ignaterState'
    },
  ],
};

/// Descriptor for `IgnitionSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List ignitionSettingsDescriptor = $convert.base64Decode(
    'ChBJZ25pdGlvblNldHRpbmdzEkQKD2lnbml0aW9uX21ldGhvZBgBIAEoDjIbLnBlbGxldHN0b3'
    'ZlLklnbml0aW9uTWV0aG9kUg5pZ25pdGlvbk1ldGhvZBI+Cg1pZ25hdGVyX3N0YXRlGAIgASgO'
    'MhkucGVsbGV0c3RvdmUuSWduaXRlclN0YXRlUgxpZ25hdGVyU3RhdGU=');

@$core.Deprecated('Use trimSettingsDescriptor instead')
const TrimSettings$json = {
  '1': 'TrimSettings',
};

/// Descriptor for `TrimSettings`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trimSettingsDescriptor =
    $convert.base64Decode('CgxUcmltU2V0dGluZ3M=');

@$core.Deprecated('Use timeOfDayDescriptor instead')
const TimeOfDay$json = {
  '1': 'TimeOfDay',
  '2': [
    {'1': 'hours', '3': 1, '4': 1, '5': 13, '10': 'hours'},
    {'1': 'minutes', '3': 2, '4': 1, '5': 13, '10': 'minutes'},
  ],
};

/// Descriptor for `TimeOfDay`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeOfDayDescriptor = $convert.base64Decode(
    'CglUaW1lT2ZEYXkSFAoFaG91cnMYASABKA1SBWhvdXJzEhgKB21pbnV0ZXMYAiABKA1SB21pbn'
    'V0ZXM=');

@$core.Deprecated('Use scheduleItemDescriptor instead')
const ScheduleItem$json = {
  '1': 'ScheduleItem',
  '2': [
    {
      '1': 'time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.TimeOfDay',
      '10': 'time'
    },
    {'1': 'temperature', '3': 2, '4': 1, '5': 13, '10': 'temperature'},
    {'1': 'whisper', '3': 3, '4': 1, '5': 8, '10': 'whisper'},
  ],
};

/// Descriptor for `ScheduleItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduleItemDescriptor = $convert.base64Decode(
    'CgxTY2hlZHVsZUl0ZW0SKgoEdGltZRgBIAEoCzIWLnBlbGxldHN0b3ZlLlRpbWVPZkRheVIEdG'
    'ltZRIgCgt0ZW1wZXJhdHVyZRgCIAEoDVILdGVtcGVyYXR1cmUSGAoHd2hpc3BlchgDIAEoCFIH'
    'd2hpc3Blcg==');

@$core.Deprecated('Use scheduleDayOptionsDescriptor instead')
const ScheduleDayOptions$json = {
  '1': 'ScheduleDayOptions',
  '2': [
    {
      '1': 'wake',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.ScheduleItem',
      '10': 'wake'
    },
    {
      '1': 'away',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.ScheduleItem',
      '10': 'away'
    },
    {
      '1': 'home',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.ScheduleItem',
      '10': 'home'
    },
    {
      '1': 'sleep',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.ScheduleItem',
      '10': 'sleep'
    },
  ],
};

/// Descriptor for `ScheduleDayOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduleDayOptionsDescriptor = $convert.base64Decode(
    'ChJTY2hlZHVsZURheU9wdGlvbnMSLQoEd2FrZRgBIAEoCzIZLnBlbGxldHN0b3ZlLlNjaGVkdW'
    'xlSXRlbVIEd2FrZRItCgRhd2F5GAIgASgLMhkucGVsbGV0c3RvdmUuU2NoZWR1bGVJdGVtUgRh'
    'd2F5Ei0KBGhvbWUYAyABKAsyGS5wZWxsZXRzdG92ZS5TY2hlZHVsZUl0ZW1SBGhvbWUSLwoFc2'
    'xlZXAYBCABKAsyGS5wZWxsZXRzdG92ZS5TY2hlZHVsZUl0ZW1SBXNsZWVw');

@$core.Deprecated('Use scheduleDescriptor instead')
const Schedule$json = {
  '1': 'Schedule',
  '2': [
    {
      '1': 'monday',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.ScheduleDayOptions',
      '10': 'monday'
    },
    {
      '1': 'tuesday',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.ScheduleDayOptions',
      '10': 'tuesday'
    },
    {
      '1': 'wednesday',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.ScheduleDayOptions',
      '10': 'wednesday'
    },
    {
      '1': 'thursday',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.ScheduleDayOptions',
      '10': 'thursday'
    },
    {
      '1': 'friday',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.ScheduleDayOptions',
      '10': 'friday'
    },
    {
      '1': 'saturday',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.ScheduleDayOptions',
      '10': 'saturday'
    },
    {
      '1': 'sunday',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.ScheduleDayOptions',
      '10': 'sunday'
    },
  ],
};

/// Descriptor for `Schedule`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduleDescriptor = $convert.base64Decode(
    'CghTY2hlZHVsZRI3CgZtb25kYXkYASABKAsyHy5wZWxsZXRzdG92ZS5TY2hlZHVsZURheU9wdG'
    'lvbnNSBm1vbmRheRI5Cgd0dWVzZGF5GAIgASgLMh8ucGVsbGV0c3RvdmUuU2NoZWR1bGVEYXlP'
    'cHRpb25zUgd0dWVzZGF5Ej0KCXdlZG5lc2RheRgDIAEoCzIfLnBlbGxldHN0b3ZlLlNjaGVkdW'
    'xlRGF5T3B0aW9uc1IJd2VkbmVzZGF5EjsKCHRodXJzZGF5GAQgASgLMh8ucGVsbGV0c3RvdmUu'
    'U2NoZWR1bGVEYXlPcHRpb25zUgh0aHVyc2RheRI3CgZmcmlkYXkYBSABKAsyHy5wZWxsZXRzdG'
    '92ZS5TY2hlZHVsZURheU9wdGlvbnNSBmZyaWRheRI7CghzYXR1cmRheRgGIAEoCzIfLnBlbGxl'
    'dHN0b3ZlLlNjaGVkdWxlRGF5T3B0aW9uc1IIc2F0dXJkYXkSNwoGc3VuZGF5GAcgASgLMh8ucG'
    'VsbGV0c3RvdmUuU2NoZWR1bGVEYXlPcHRpb25zUgZzdW5kYXk=');

@$core.Deprecated('Use deviceDescriptor instead')
const Device$json = {
  '1': 'Device',
};

/// Descriptor for `Device`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deviceDescriptor =
    $convert.base64Decode('CgZEZXZpY2U=');

@$core.Deprecated('Use commandDescriptor instead')
const Command$json = {
  '1': 'Command',
  '2': [
    {'1': 'command_id', '3': 1, '4': 1, '5': 5, '10': 'commandId'},
    {'1': 'onOff', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'onOff'},
    {'1': 'level', '3': 3, '4': 1, '5': 17, '9': 0, '10': 'level'},
    {
      '1': 'range',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.Range',
      '9': 0,
      '10': 'range'
    },
    {
      '1': 'ignition_settings',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.IgnitionSettings',
      '9': 0,
      '10': 'ignitionSettings'
    },
    {
      '1': 'burn_mode',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.pelletstove.BurnMode',
      '9': 0,
      '10': 'burnMode'
    },
    {
      '1': 'fan_speed',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.pelletstove.FanSpeed',
      '9': 0,
      '10': 'fanSpeed'
    },
    {
      '1': 'cleaning_prompt',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.pelletstove.CleaningPrompt',
      '9': 0,
      '10': 'cleaningPrompt'
    },
    {
      '1': 'trim_settings',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.TrimSettings',
      '9': 0,
      '10': 'trimSettings'
    },
    {
      '1': 'illumination_brightness',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.pelletstove.IlluminationBrightness',
      '9': 0,
      '10': 'illuminationBrightness'
    },
    {
      '1': 'illumination_color',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.pelletstove.IlluminationColor',
      '9': 0,
      '10': 'illuminationColor'
    },
    {
      '1': 'visual_fx',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.pelletstove.VisualFX',
      '9': 0,
      '10': 'visualFx'
    },
    {
      '1': 'schedule',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.Schedule',
      '9': 0,
      '10': 'schedule'
    },
    {
      '1': 'device',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.pelletstove.Device',
      '9': 0,
      '10': 'device'
    },
  ],
  '8': [
    {'1': 'arguments'},
  ],
};

/// Descriptor for `Command`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandDescriptor = $convert.base64Decode(
    'CgdDb21tYW5kEh0KCmNvbW1hbmRfaWQYASABKAVSCWNvbW1hbmRJZBIWCgVvbk9mZhgCIAEoCE'
    'gAUgVvbk9mZhIWCgVsZXZlbBgDIAEoEUgAUgVsZXZlbBIqCgVyYW5nZRgEIAEoCzISLnBlbGxl'
    'dHN0b3ZlLlJhbmdlSABSBXJhbmdlEkwKEWlnbml0aW9uX3NldHRpbmdzGAUgASgLMh0ucGVsbG'
    'V0c3RvdmUuSWduaXRpb25TZXR0aW5nc0gAUhBpZ25pdGlvblNldHRpbmdzEjQKCWJ1cm5fbW9k'
    'ZRgGIAEoDjIVLnBlbGxldHN0b3ZlLkJ1cm5Nb2RlSABSCGJ1cm5Nb2RlEjQKCWZhbl9zcGVlZB'
    'gHIAEoDjIVLnBlbGxldHN0b3ZlLkZhblNwZWVkSABSCGZhblNwZWVkEkYKD2NsZWFuaW5nX3By'
    'b21wdBgIIAEoDjIbLnBlbGxldHN0b3ZlLkNsZWFuaW5nUHJvbXB0SABSDmNsZWFuaW5nUHJvbX'
    'B0EkAKDXRyaW1fc2V0dGluZ3MYCSABKAsyGS5wZWxsZXRzdG92ZS5UcmltU2V0dGluZ3NIAFIM'
    'dHJpbVNldHRpbmdzEl4KF2lsbHVtaW5hdGlvbl9icmlnaHRuZXNzGAogASgOMiMucGVsbGV0c3'
    'RvdmUuSWxsdW1pbmF0aW9uQnJpZ2h0bmVzc0gAUhZpbGx1bWluYXRpb25CcmlnaHRuZXNzEk8K'
    'EmlsbHVtaW5hdGlvbl9jb2xvchgLIAEoDjIeLnBlbGxldHN0b3ZlLklsbHVtaW5hdGlvbkNvbG'
    '9ySABSEWlsbHVtaW5hdGlvbkNvbG9yEjQKCXZpc3VhbF9meBgMIAEoDjIVLnBlbGxldHN0b3Zl'
    'LlZpc3VhbEZYSABSCHZpc3VhbEZ4EjMKCHNjaGVkdWxlGA0gASgLMhUucGVsbGV0c3RvdmUuU2'
    'NoZWR1bGVIAFIIc2NoZWR1bGUSLQoGZGV2aWNlGA4gASgLMhMucGVsbGV0c3RvdmUuRGV2aWNl'
    'SABSBmRldmljZUILCglhcmd1bWVudHM=');
