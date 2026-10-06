// This is a generated file - do not edit.
//
// Generated from pellet_stove_commands.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class IgnitionMethod extends $pb.ProtobufEnum {
  static const IgnitionMethod SHUT_DOWN =
      IgnitionMethod._(0, _omitEnumNames ? '' : 'SHUT_DOWN');
  static const IgnitionMethod AUTOMATIC =
      IgnitionMethod._(1, _omitEnumNames ? '' : 'AUTOMATIC');
  static const IgnitionMethod DISABLED =
      IgnitionMethod._(2, _omitEnumNames ? '' : 'DISABLED');

  static const $core.List<IgnitionMethod> values = <IgnitionMethod>[
    SHUT_DOWN,
    AUTOMATIC,
    DISABLED,
  ];

  static final $core.List<IgnitionMethod?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static IgnitionMethod? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const IgnitionMethod._(super.value, super.name);
}

class IgniterState extends $pb.ProtobufEnum {
  static const IgniterState ACTIVE =
      IgniterState._(0, _omitEnumNames ? '' : 'ACTIVE');
  static const IgniterState INACTIVE =
      IgniterState._(1, _omitEnumNames ? '' : 'INACTIVE');
  static const IgniterState IN_TRANSITION =
      IgniterState._(2, _omitEnumNames ? '' : 'IN_TRANSITION');

  static const $core.List<IgniterState> values = <IgniterState>[
    ACTIVE,
    INACTIVE,
    IN_TRANSITION,
  ];

  static final $core.List<IgniterState?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static IgniterState? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const IgniterState._(super.value, super.name);
}

class BurnMode extends $pb.ProtobufEnum {
  static const BurnMode ROOM_SENSING =
      BurnMode._(0, _omitEnumNames ? '' : 'ROOM_SENSING');
  static const BurnMode CONSTANT_BURN_SENSING =
      BurnMode._(1, _omitEnumNames ? '' : 'CONSTANT_BURN_SENSING');

  static const $core.List<BurnMode> values = <BurnMode>[
    ROOM_SENSING,
    CONSTANT_BURN_SENSING,
  ];

  static final $core.List<BurnMode?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static BurnMode? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const BurnMode._(super.value, super.name);
}

class FanSpeed extends $pb.ProtobufEnum {
  static const FanSpeed FAN_SPEED_LOW =
      FanSpeed._(0, _omitEnumNames ? '' : 'FAN_SPEED_LOW');
  static const FanSpeed FAN_SPEED_MEDIUM =
      FanSpeed._(1, _omitEnumNames ? '' : 'FAN_SPEED_MEDIUM');
  static const FanSpeed FAN_SPEED_HIGH =
      FanSpeed._(2, _omitEnumNames ? '' : 'FAN_SPEED_HIGH');
  static const FanSpeed FAN_SPEED_MAX =
      FanSpeed._(3, _omitEnumNames ? '' : 'FAN_SPEED_MAX');

  static const $core.List<FanSpeed> values = <FanSpeed>[
    FAN_SPEED_LOW,
    FAN_SPEED_MEDIUM,
    FAN_SPEED_HIGH,
    FAN_SPEED_MAX,
  ];

  static final $core.List<FanSpeed?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static FanSpeed? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const FanSpeed._(super.value, super.name);
}

class CleaningPrompt extends $pb.ProtobufEnum {
  static const CleaningPrompt BURN_POT =
      CleaningPrompt._(0, _omitEnumNames ? '' : 'BURN_POT');
  static const CleaningPrompt ASH_PAN =
      CleaningPrompt._(1, _omitEnumNames ? '' : 'ASH_PAN');
  static const CleaningPrompt TOTAL_CLEAN =
      CleaningPrompt._(2, _omitEnumNames ? '' : 'TOTAL_CLEAN');

  static const $core.List<CleaningPrompt> values = <CleaningPrompt>[
    BURN_POT,
    ASH_PAN,
    TOTAL_CLEAN,
  ];

  static final $core.List<CleaningPrompt?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static CleaningPrompt? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CleaningPrompt._(super.value, super.name);
}

class IlluminationBrightness extends $pb.ProtobufEnum {
  static const IlluminationBrightness BRIGHTNESS_LOW =
      IlluminationBrightness._(0, _omitEnumNames ? '' : 'BRIGHTNESS_LOW');
  static const IlluminationBrightness BRIGHTNESS_MEDIUM =
      IlluminationBrightness._(1, _omitEnumNames ? '' : 'BRIGHTNESS_MEDIUM');
  static const IlluminationBrightness BRIGHTNESS_HIGH =
      IlluminationBrightness._(2, _omitEnumNames ? '' : 'BRIGHTNESS_HIGH');

  static const $core.List<IlluminationBrightness> values =
      <IlluminationBrightness>[
    BRIGHTNESS_LOW,
    BRIGHTNESS_MEDIUM,
    BRIGHTNESS_HIGH,
  ];

  static final $core.List<IlluminationBrightness?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static IlluminationBrightness? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const IlluminationBrightness._(super.value, super.name);
}

class IlluminationColor extends $pb.ProtobufEnum {
  static const IlluminationColor BLUE =
      IlluminationColor._(0, _omitEnumNames ? '' : 'BLUE');
  static const IlluminationColor GREEN =
      IlluminationColor._(1, _omitEnumNames ? '' : 'GREEN');
  static const IlluminationColor RED =
      IlluminationColor._(2, _omitEnumNames ? '' : 'RED');
  static const IlluminationColor WHITE =
      IlluminationColor._(3, _omitEnumNames ? '' : 'WHITE');

  static const $core.List<IlluminationColor> values = <IlluminationColor>[
    BLUE,
    GREEN,
    RED,
    WHITE,
  ];

  static final $core.List<IlluminationColor?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static IlluminationColor? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const IlluminationColor._(super.value, super.name);
}

class VisualFX extends $pb.ProtobufEnum {
  static const VisualFX FX_NONE =
      VisualFX._(0, _omitEnumNames ? '' : 'FX_NONE');

  static const $core.List<VisualFX> values = <VisualFX>[
    FX_NONE,
  ];

  static final $core.List<VisualFX?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 0);
  static VisualFX? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VisualFX._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
