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

import 'pellet_stove_commands.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'pellet_stove_commands.pbenum.dart';

class Range extends $pb.GeneratedMessage {
  factory Range({
    $core.int? minimum,
    $core.int? maximum,
  }) {
    final result = Range._();
    if (minimum != null) result.minimum = minimum;
    if (maximum != null) result.maximum = maximum;
    return result;
  }

  Range._();

  factory Range.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Range()..mergeFromBuffer(data, registry);
  factory Range.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Range()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Range',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pelletstove'),
      createEmptyInstance: Range.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'minimum', fieldType: $pb.PbFieldType.OS3)
    ..aI(2, _omitFieldNames ? '' : 'maximum', fieldType: $pb.PbFieldType.OS3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Range clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Range copyWith(void Function(Range) updates) =>
      super.copyWith((message) => updates(message as Range)) as Range;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Range() / Range.new instead')
  static Range create() => Range._();
  static $pb.GeneratedMessage $_createMessage() => Range._();
  @$core.override
  Range createEmptyInstance() => Range._();
  @$core.pragma('dart2js:noInline')
  static Range getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Range>(Range.$_createMessage);
  static Range? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get minimum => $_getIZ(0);
  @$pb.TagNumber(1)
  set minimum($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMinimum() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinimum() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get maximum => $_getIZ(1);
  @$pb.TagNumber(2)
  set maximum($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaximum() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaximum() => $_clearField(2);
}

class IgnitionSettings extends $pb.GeneratedMessage {
  factory IgnitionSettings({
    IgnitionMethod? ignitionMethod,
    IgniterState? ignaterState,
  }) {
    final result = IgnitionSettings._();
    if (ignitionMethod != null) result.ignitionMethod = ignitionMethod;
    if (ignaterState != null) result.ignaterState = ignaterState;
    return result;
  }

  IgnitionSettings._();

  factory IgnitionSettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      IgnitionSettings()..mergeFromBuffer(data, registry);
  factory IgnitionSettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      IgnitionSettings()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IgnitionSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pelletstove'),
      createEmptyInstance: IgnitionSettings.$_createMessage)
    ..aE<IgnitionMethod>(1, _omitFieldNames ? '' : 'ignitionMethod',
        enumValues: IgnitionMethod.values)
    ..aE<IgniterState>(2, _omitFieldNames ? '' : 'ignaterState',
        enumValues: IgniterState.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IgnitionSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IgnitionSettings copyWith(void Function(IgnitionSettings) updates) =>
      super.copyWith((message) => updates(message as IgnitionSettings))
          as IgnitionSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use IgnitionSettings() / IgnitionSettings.new instead')
  static IgnitionSettings create() => IgnitionSettings._();
  static $pb.GeneratedMessage $_createMessage() => IgnitionSettings._();
  @$core.override
  IgnitionSettings createEmptyInstance() => IgnitionSettings._();
  @$core.pragma('dart2js:noInline')
  static IgnitionSettings getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IgnitionSettings>(
          IgnitionSettings.$_createMessage);
  static IgnitionSettings? _defaultInstance;

  @$pb.TagNumber(1)
  IgnitionMethod get ignitionMethod => $_getN(0);
  @$pb.TagNumber(1)
  set ignitionMethod(IgnitionMethod value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasIgnitionMethod() => $_has(0);
  @$pb.TagNumber(1)
  void clearIgnitionMethod() => $_clearField(1);

  @$pb.TagNumber(2)
  IgniterState get ignaterState => $_getN(1);
  @$pb.TagNumber(2)
  set ignaterState(IgniterState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasIgnaterState() => $_has(1);
  @$pb.TagNumber(2)
  void clearIgnaterState() => $_clearField(2);
}

class TrimSettings extends $pb.GeneratedMessage {
  factory TrimSettings() => TrimSettings._();

  TrimSettings._();

  factory TrimSettings.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TrimSettings()..mergeFromBuffer(data, registry);
  factory TrimSettings.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TrimSettings()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TrimSettings',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pelletstove'),
      createEmptyInstance: TrimSettings.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrimSettings clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TrimSettings copyWith(void Function(TrimSettings) updates) =>
      super.copyWith((message) => updates(message as TrimSettings))
          as TrimSettings;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TrimSettings() / TrimSettings.new instead')
  static TrimSettings create() => TrimSettings._();
  static $pb.GeneratedMessage $_createMessage() => TrimSettings._();
  @$core.override
  TrimSettings createEmptyInstance() => TrimSettings._();
  @$core.pragma('dart2js:noInline')
  static TrimSettings getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TrimSettings>(
          TrimSettings.$_createMessage);
  static TrimSettings? _defaultInstance;
}

class TimeOfDay extends $pb.GeneratedMessage {
  factory TimeOfDay({
    $core.int? hours,
    $core.int? minutes,
  }) {
    final result = TimeOfDay._();
    if (hours != null) result.hours = hours;
    if (minutes != null) result.minutes = minutes;
    return result;
  }

  TimeOfDay._();

  factory TimeOfDay.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TimeOfDay()..mergeFromBuffer(data, registry);
  factory TimeOfDay.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TimeOfDay()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TimeOfDay',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pelletstove'),
      createEmptyInstance: TimeOfDay.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'hours', fieldType: $pb.PbFieldType.OU3)
    ..aI(2, _omitFieldNames ? '' : 'minutes', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeOfDay clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeOfDay copyWith(void Function(TimeOfDay) updates) =>
      super.copyWith((message) => updates(message as TimeOfDay)) as TimeOfDay;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TimeOfDay() / TimeOfDay.new instead')
  static TimeOfDay create() => TimeOfDay._();
  static $pb.GeneratedMessage $_createMessage() => TimeOfDay._();
  @$core.override
  TimeOfDay createEmptyInstance() => TimeOfDay._();
  @$core.pragma('dart2js:noInline')
  static TimeOfDay getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TimeOfDay>(TimeOfDay.$_createMessage);
  static TimeOfDay? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get hours => $_getIZ(0);
  @$pb.TagNumber(1)
  set hours($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHours() => $_has(0);
  @$pb.TagNumber(1)
  void clearHours() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get minutes => $_getIZ(1);
  @$pb.TagNumber(2)
  set minutes($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMinutes() => $_has(1);
  @$pb.TagNumber(2)
  void clearMinutes() => $_clearField(2);
}

class ScheduleItem extends $pb.GeneratedMessage {
  factory ScheduleItem({
    TimeOfDay? time,
    $core.int? temperature,
    $core.bool? whisper,
  }) {
    final result = ScheduleItem._();
    if (time != null) result.time = time;
    if (temperature != null) result.temperature = temperature;
    if (whisper != null) result.whisper = whisper;
    return result;
  }

  ScheduleItem._();

  factory ScheduleItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ScheduleItem()..mergeFromBuffer(data, registry);
  factory ScheduleItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ScheduleItem()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScheduleItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pelletstove'),
      createEmptyInstance: ScheduleItem.$_createMessage)
    ..aOM<TimeOfDay>(1, _omitFieldNames ? '' : 'time',
        subBuilder: TimeOfDay.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'temperature',
        fieldType: $pb.PbFieldType.OU3)
    ..aOB(3, _omitFieldNames ? '' : 'whisper')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScheduleItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScheduleItem copyWith(void Function(ScheduleItem) updates) =>
      super.copyWith((message) => updates(message as ScheduleItem))
          as ScheduleItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ScheduleItem() / ScheduleItem.new instead')
  static ScheduleItem create() => ScheduleItem._();
  static $pb.GeneratedMessage $_createMessage() => ScheduleItem._();
  @$core.override
  ScheduleItem createEmptyInstance() => ScheduleItem._();
  @$core.pragma('dart2js:noInline')
  static ScheduleItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ScheduleItem>(
          ScheduleItem.$_createMessage);
  static ScheduleItem? _defaultInstance;

  @$pb.TagNumber(1)
  TimeOfDay get time => $_getN(0);
  @$pb.TagNumber(1)
  set time(TimeOfDay value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearTime() => $_clearField(1);
  @$pb.TagNumber(1)
  TimeOfDay ensureTime() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.int get temperature => $_getIZ(1);
  @$pb.TagNumber(2)
  set temperature($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTemperature() => $_has(1);
  @$pb.TagNumber(2)
  void clearTemperature() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get whisper => $_getBF(2);
  @$pb.TagNumber(3)
  set whisper($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWhisper() => $_has(2);
  @$pb.TagNumber(3)
  void clearWhisper() => $_clearField(3);
}

class ScheduleDayOptions extends $pb.GeneratedMessage {
  factory ScheduleDayOptions({
    ScheduleItem? wake,
    ScheduleItem? away,
    ScheduleItem? home,
    ScheduleItem? sleep,
  }) {
    final result = ScheduleDayOptions._();
    if (wake != null) result.wake = wake;
    if (away != null) result.away = away;
    if (home != null) result.home = home;
    if (sleep != null) result.sleep = sleep;
    return result;
  }

  ScheduleDayOptions._();

  factory ScheduleDayOptions.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ScheduleDayOptions()..mergeFromBuffer(data, registry);
  factory ScheduleDayOptions.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ScheduleDayOptions()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScheduleDayOptions',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pelletstove'),
      createEmptyInstance: ScheduleDayOptions.$_createMessage)
    ..aOM<ScheduleItem>(1, _omitFieldNames ? '' : 'wake',
        subBuilder: ScheduleItem.$_createMessage)
    ..aOM<ScheduleItem>(2, _omitFieldNames ? '' : 'away',
        subBuilder: ScheduleItem.$_createMessage)
    ..aOM<ScheduleItem>(3, _omitFieldNames ? '' : 'home',
        subBuilder: ScheduleItem.$_createMessage)
    ..aOM<ScheduleItem>(4, _omitFieldNames ? '' : 'sleep',
        subBuilder: ScheduleItem.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScheduleDayOptions clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScheduleDayOptions copyWith(void Function(ScheduleDayOptions) updates) =>
      super.copyWith((message) => updates(message as ScheduleDayOptions))
          as ScheduleDayOptions;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ScheduleDayOptions() / ScheduleDayOptions.new instead')
  static ScheduleDayOptions create() => ScheduleDayOptions._();
  static $pb.GeneratedMessage $_createMessage() => ScheduleDayOptions._();
  @$core.override
  ScheduleDayOptions createEmptyInstance() => ScheduleDayOptions._();
  @$core.pragma('dart2js:noInline')
  static ScheduleDayOptions getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScheduleDayOptions>(
          ScheduleDayOptions.$_createMessage);
  static ScheduleDayOptions? _defaultInstance;

  @$pb.TagNumber(1)
  ScheduleItem get wake => $_getN(0);
  @$pb.TagNumber(1)
  set wake(ScheduleItem value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasWake() => $_has(0);
  @$pb.TagNumber(1)
  void clearWake() => $_clearField(1);
  @$pb.TagNumber(1)
  ScheduleItem ensureWake() => $_ensure(0);

  @$pb.TagNumber(2)
  ScheduleItem get away => $_getN(1);
  @$pb.TagNumber(2)
  set away(ScheduleItem value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAway() => $_has(1);
  @$pb.TagNumber(2)
  void clearAway() => $_clearField(2);
  @$pb.TagNumber(2)
  ScheduleItem ensureAway() => $_ensure(1);

  @$pb.TagNumber(3)
  ScheduleItem get home => $_getN(2);
  @$pb.TagNumber(3)
  set home(ScheduleItem value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasHome() => $_has(2);
  @$pb.TagNumber(3)
  void clearHome() => $_clearField(3);
  @$pb.TagNumber(3)
  ScheduleItem ensureHome() => $_ensure(2);

  @$pb.TagNumber(4)
  ScheduleItem get sleep => $_getN(3);
  @$pb.TagNumber(4)
  set sleep(ScheduleItem value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSleep() => $_has(3);
  @$pb.TagNumber(4)
  void clearSleep() => $_clearField(4);
  @$pb.TagNumber(4)
  ScheduleItem ensureSleep() => $_ensure(3);
}

class Schedule extends $pb.GeneratedMessage {
  factory Schedule({
    ScheduleDayOptions? monday,
    ScheduleDayOptions? tuesday,
    ScheduleDayOptions? wednesday,
    ScheduleDayOptions? thursday,
    ScheduleDayOptions? friday,
    ScheduleDayOptions? saturday,
    ScheduleDayOptions? sunday,
  }) {
    final result = Schedule._();
    if (monday != null) result.monday = monday;
    if (tuesday != null) result.tuesday = tuesday;
    if (wednesday != null) result.wednesday = wednesday;
    if (thursday != null) result.thursday = thursday;
    if (friday != null) result.friday = friday;
    if (saturday != null) result.saturday = saturday;
    if (sunday != null) result.sunday = sunday;
    return result;
  }

  Schedule._();

  factory Schedule.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Schedule()..mergeFromBuffer(data, registry);
  factory Schedule.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Schedule()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Schedule',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pelletstove'),
      createEmptyInstance: Schedule.$_createMessage)
    ..aOM<ScheduleDayOptions>(1, _omitFieldNames ? '' : 'monday',
        subBuilder: ScheduleDayOptions.$_createMessage)
    ..aOM<ScheduleDayOptions>(2, _omitFieldNames ? '' : 'tuesday',
        subBuilder: ScheduleDayOptions.$_createMessage)
    ..aOM<ScheduleDayOptions>(3, _omitFieldNames ? '' : 'wednesday',
        subBuilder: ScheduleDayOptions.$_createMessage)
    ..aOM<ScheduleDayOptions>(4, _omitFieldNames ? '' : 'thursday',
        subBuilder: ScheduleDayOptions.$_createMessage)
    ..aOM<ScheduleDayOptions>(5, _omitFieldNames ? '' : 'friday',
        subBuilder: ScheduleDayOptions.$_createMessage)
    ..aOM<ScheduleDayOptions>(6, _omitFieldNames ? '' : 'saturday',
        subBuilder: ScheduleDayOptions.$_createMessage)
    ..aOM<ScheduleDayOptions>(7, _omitFieldNames ? '' : 'sunday',
        subBuilder: ScheduleDayOptions.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Schedule clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Schedule copyWith(void Function(Schedule) updates) =>
      super.copyWith((message) => updates(message as Schedule)) as Schedule;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Schedule() / Schedule.new instead')
  static Schedule create() => Schedule._();
  static $pb.GeneratedMessage $_createMessage() => Schedule._();
  @$core.override
  Schedule createEmptyInstance() => Schedule._();
  @$core.pragma('dart2js:noInline')
  static Schedule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Schedule>(Schedule.$_createMessage);
  static Schedule? _defaultInstance;

  @$pb.TagNumber(1)
  ScheduleDayOptions get monday => $_getN(0);
  @$pb.TagNumber(1)
  set monday(ScheduleDayOptions value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMonday() => $_has(0);
  @$pb.TagNumber(1)
  void clearMonday() => $_clearField(1);
  @$pb.TagNumber(1)
  ScheduleDayOptions ensureMonday() => $_ensure(0);

  @$pb.TagNumber(2)
  ScheduleDayOptions get tuesday => $_getN(1);
  @$pb.TagNumber(2)
  set tuesday(ScheduleDayOptions value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTuesday() => $_has(1);
  @$pb.TagNumber(2)
  void clearTuesday() => $_clearField(2);
  @$pb.TagNumber(2)
  ScheduleDayOptions ensureTuesday() => $_ensure(1);

  @$pb.TagNumber(3)
  ScheduleDayOptions get wednesday => $_getN(2);
  @$pb.TagNumber(3)
  set wednesday(ScheduleDayOptions value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasWednesday() => $_has(2);
  @$pb.TagNumber(3)
  void clearWednesday() => $_clearField(3);
  @$pb.TagNumber(3)
  ScheduleDayOptions ensureWednesday() => $_ensure(2);

  @$pb.TagNumber(4)
  ScheduleDayOptions get thursday => $_getN(3);
  @$pb.TagNumber(4)
  set thursday(ScheduleDayOptions value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasThursday() => $_has(3);
  @$pb.TagNumber(4)
  void clearThursday() => $_clearField(4);
  @$pb.TagNumber(4)
  ScheduleDayOptions ensureThursday() => $_ensure(3);

  @$pb.TagNumber(5)
  ScheduleDayOptions get friday => $_getN(4);
  @$pb.TagNumber(5)
  set friday(ScheduleDayOptions value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasFriday() => $_has(4);
  @$pb.TagNumber(5)
  void clearFriday() => $_clearField(5);
  @$pb.TagNumber(5)
  ScheduleDayOptions ensureFriday() => $_ensure(4);

  @$pb.TagNumber(6)
  ScheduleDayOptions get saturday => $_getN(5);
  @$pb.TagNumber(6)
  set saturday(ScheduleDayOptions value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasSaturday() => $_has(5);
  @$pb.TagNumber(6)
  void clearSaturday() => $_clearField(6);
  @$pb.TagNumber(6)
  ScheduleDayOptions ensureSaturday() => $_ensure(5);

  @$pb.TagNumber(7)
  ScheduleDayOptions get sunday => $_getN(6);
  @$pb.TagNumber(7)
  set sunday(ScheduleDayOptions value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasSunday() => $_has(6);
  @$pb.TagNumber(7)
  void clearSunday() => $_clearField(7);
  @$pb.TagNumber(7)
  ScheduleDayOptions ensureSunday() => $_ensure(6);
}

class Device extends $pb.GeneratedMessage {
  factory Device() => Device._();

  Device._();

  factory Device.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Device()..mergeFromBuffer(data, registry);
  factory Device.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Device()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Device',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pelletstove'),
      createEmptyInstance: Device.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Device clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Device copyWith(void Function(Device) updates) =>
      super.copyWith((message) => updates(message as Device)) as Device;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Device() / Device.new instead')
  static Device create() => Device._();
  static $pb.GeneratedMessage $_createMessage() => Device._();
  @$core.override
  Device createEmptyInstance() => Device._();
  @$core.pragma('dart2js:noInline')
  static Device getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Device>(Device.$_createMessage);
  static Device? _defaultInstance;
}

enum Command_Arguments {
  onOff,
  level,
  range,
  ignitionSettings,
  burnMode,
  fanSpeed,
  cleaningPrompt,
  trimSettings,
  illuminationBrightness,
  illuminationColor,
  visualFx,
  schedule,
  device,
  notSet
}

class Command extends $pb.GeneratedMessage {
  factory Command({
    $core.int? commandId,
    $core.bool? onOff,
    $core.int? level,
    Range? range,
    IgnitionSettings? ignitionSettings,
    BurnMode? burnMode,
    FanSpeed? fanSpeed,
    CleaningPrompt? cleaningPrompt,
    TrimSettings? trimSettings,
    IlluminationBrightness? illuminationBrightness,
    IlluminationColor? illuminationColor,
    VisualFX? visualFx,
    Schedule? schedule,
    Device? device,
  }) {
    final result = Command._();
    if (commandId != null) result.commandId = commandId;
    if (onOff != null) result.onOff = onOff;
    if (level != null) result.level = level;
    if (range != null) result.range = range;
    if (ignitionSettings != null) result.ignitionSettings = ignitionSettings;
    if (burnMode != null) result.burnMode = burnMode;
    if (fanSpeed != null) result.fanSpeed = fanSpeed;
    if (cleaningPrompt != null) result.cleaningPrompt = cleaningPrompt;
    if (trimSettings != null) result.trimSettings = trimSettings;
    if (illuminationBrightness != null)
      result.illuminationBrightness = illuminationBrightness;
    if (illuminationColor != null) result.illuminationColor = illuminationColor;
    if (visualFx != null) result.visualFx = visualFx;
    if (schedule != null) result.schedule = schedule;
    if (device != null) result.device = device;
    return result;
  }

  Command._();

  factory Command.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Command()..mergeFromBuffer(data, registry);
  factory Command.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Command()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Command_Arguments> _Command_ArgumentsByTag =
      {
    2: Command_Arguments.onOff,
    3: Command_Arguments.level,
    4: Command_Arguments.range,
    5: Command_Arguments.ignitionSettings,
    6: Command_Arguments.burnMode,
    7: Command_Arguments.fanSpeed,
    8: Command_Arguments.cleaningPrompt,
    9: Command_Arguments.trimSettings,
    10: Command_Arguments.illuminationBrightness,
    11: Command_Arguments.illuminationColor,
    12: Command_Arguments.visualFx,
    13: Command_Arguments.schedule,
    14: Command_Arguments.device,
    0: Command_Arguments.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Command',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'pelletstove'),
      createEmptyInstance: Command.$_createMessage)
    ..oo(0, [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])
    ..aI(1, _omitFieldNames ? '' : 'commandId')
    ..aOB(2, _omitFieldNames ? '' : 'onOff', protoName: 'onOff')
    ..aI(3, _omitFieldNames ? '' : 'level', fieldType: $pb.PbFieldType.OS3)
    ..aOM<Range>(4, _omitFieldNames ? '' : 'range',
        subBuilder: Range.$_createMessage)
    ..aOM<IgnitionSettings>(5, _omitFieldNames ? '' : 'ignitionSettings',
        subBuilder: IgnitionSettings.$_createMessage)
    ..aE<BurnMode>(6, _omitFieldNames ? '' : 'burnMode',
        enumValues: BurnMode.values)
    ..aE<FanSpeed>(7, _omitFieldNames ? '' : 'fanSpeed',
        enumValues: FanSpeed.values)
    ..aE<CleaningPrompt>(8, _omitFieldNames ? '' : 'cleaningPrompt',
        enumValues: CleaningPrompt.values)
    ..aOM<TrimSettings>(9, _omitFieldNames ? '' : 'trimSettings',
        subBuilder: TrimSettings.$_createMessage)
    ..aE<IlluminationBrightness>(
        10, _omitFieldNames ? '' : 'illuminationBrightness',
        enumValues: IlluminationBrightness.values)
    ..aE<IlluminationColor>(11, _omitFieldNames ? '' : 'illuminationColor',
        enumValues: IlluminationColor.values)
    ..aE<VisualFX>(12, _omitFieldNames ? '' : 'visualFx',
        enumValues: VisualFX.values)
    ..aOM<Schedule>(13, _omitFieldNames ? '' : 'schedule',
        subBuilder: Schedule.$_createMessage)
    ..aOM<Device>(14, _omitFieldNames ? '' : 'device',
        subBuilder: Device.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Command clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Command copyWith(void Function(Command) updates) =>
      super.copyWith((message) => updates(message as Command)) as Command;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Command() / Command.new instead')
  static Command create() => Command._();
  static $pb.GeneratedMessage $_createMessage() => Command._();
  @$core.override
  Command createEmptyInstance() => Command._();
  @$core.pragma('dart2js:noInline')
  static Command getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Command>(Command.$_createMessage);
  static Command? _defaultInstance;

  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  Command_Arguments whichArguments() =>
      _Command_ArgumentsByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  void clearArguments() => $_clearField($_whichOneof(0));

  /// The command identifier (1 to 22)
  @$pb.TagNumber(1)
  $core.int get commandId => $_getIZ(0);
  @$pb.TagNumber(1)
  set commandId($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCommandId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommandId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get onOff => $_getBF(1);
  @$pb.TagNumber(2)
  set onOff($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOnOff() => $_has(1);
  @$pb.TagNumber(2)
  void clearOnOff() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get level => $_getIZ(2);
  @$pb.TagNumber(3)
  set level($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLevel() => $_has(2);
  @$pb.TagNumber(3)
  void clearLevel() => $_clearField(3);

  @$pb.TagNumber(4)
  Range get range => $_getN(3);
  @$pb.TagNumber(4)
  set range(Range value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasRange() => $_has(3);
  @$pb.TagNumber(4)
  void clearRange() => $_clearField(4);
  @$pb.TagNumber(4)
  Range ensureRange() => $_ensure(3);

  @$pb.TagNumber(5)
  IgnitionSettings get ignitionSettings => $_getN(4);
  @$pb.TagNumber(5)
  set ignitionSettings(IgnitionSettings value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasIgnitionSettings() => $_has(4);
  @$pb.TagNumber(5)
  void clearIgnitionSettings() => $_clearField(5);
  @$pb.TagNumber(5)
  IgnitionSettings ensureIgnitionSettings() => $_ensure(4);

  @$pb.TagNumber(6)
  BurnMode get burnMode => $_getN(5);
  @$pb.TagNumber(6)
  set burnMode(BurnMode value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasBurnMode() => $_has(5);
  @$pb.TagNumber(6)
  void clearBurnMode() => $_clearField(6);

  @$pb.TagNumber(7)
  FanSpeed get fanSpeed => $_getN(6);
  @$pb.TagNumber(7)
  set fanSpeed(FanSpeed value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasFanSpeed() => $_has(6);
  @$pb.TagNumber(7)
  void clearFanSpeed() => $_clearField(7);

  @$pb.TagNumber(8)
  CleaningPrompt get cleaningPrompt => $_getN(7);
  @$pb.TagNumber(8)
  set cleaningPrompt(CleaningPrompt value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasCleaningPrompt() => $_has(7);
  @$pb.TagNumber(8)
  void clearCleaningPrompt() => $_clearField(8);

  @$pb.TagNumber(9)
  TrimSettings get trimSettings => $_getN(8);
  @$pb.TagNumber(9)
  set trimSettings(TrimSettings value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasTrimSettings() => $_has(8);
  @$pb.TagNumber(9)
  void clearTrimSettings() => $_clearField(9);
  @$pb.TagNumber(9)
  TrimSettings ensureTrimSettings() => $_ensure(8);

  @$pb.TagNumber(10)
  IlluminationBrightness get illuminationBrightness => $_getN(9);
  @$pb.TagNumber(10)
  set illuminationBrightness(IlluminationBrightness value) =>
      $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasIlluminationBrightness() => $_has(9);
  @$pb.TagNumber(10)
  void clearIlluminationBrightness() => $_clearField(10);

  @$pb.TagNumber(11)
  IlluminationColor get illuminationColor => $_getN(10);
  @$pb.TagNumber(11)
  set illuminationColor(IlluminationColor value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasIlluminationColor() => $_has(10);
  @$pb.TagNumber(11)
  void clearIlluminationColor() => $_clearField(11);

  @$pb.TagNumber(12)
  VisualFX get visualFx => $_getN(11);
  @$pb.TagNumber(12)
  set visualFx(VisualFX value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasVisualFx() => $_has(11);
  @$pb.TagNumber(12)
  void clearVisualFx() => $_clearField(12);

  @$pb.TagNumber(13)
  Schedule get schedule => $_getN(12);
  @$pb.TagNumber(13)
  set schedule(Schedule value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasSchedule() => $_has(12);
  @$pb.TagNumber(13)
  void clearSchedule() => $_clearField(13);
  @$pb.TagNumber(13)
  Schedule ensureSchedule() => $_ensure(12);

  @$pb.TagNumber(14)
  Device get device => $_getN(13);
  @$pb.TagNumber(14)
  set device(Device value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasDevice() => $_has(13);
  @$pb.TagNumber(14)
  void clearDevice() => $_clearField(14);
  @$pb.TagNumber(14)
  Device ensureDevice() => $_ensure(13);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
