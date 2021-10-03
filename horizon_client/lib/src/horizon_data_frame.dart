import 'dart:typed_data';

extension ByteDataExtension on ByteData {
  int getU32(int offset) => getUint32(offset, Endian.little);
  int getU16(int offset) => getUint16(offset, Endian.little);
  double getF32(int offset) => getFloat32(offset, Endian.little);
  int getS32(int offset) => getInt32(offset, Endian.little);
  int getS8(int offset) => getInt8(offset);
}

class HorizonDataFrame {
  static const int expectedLength = 324;
  final int
  isRaceOn; // = 1 when race is on. = 0 when in menus/race stopped …
  final int timestampMS; //Can overflow to 0 eventually
  final double engineMaxRpm;
  final double engineIdleRpm;
  final double currentEngineRpm;
  final double
  accelerationX; //In the car's local space; X = right, Y = up, Z = forward
  final double accelerationY;
  final double accelerationZ;
  final double
  velocityX; //In the car's local space; X = right, Y = up, Z = forward
  final double velocityY;
  final double velocityZ;
  final double
  angularVelocityX; //In the car's local space; X = pitch, Y = yaw, Z = roll
  final double angularVelocityY;
  final double angularVelocityZ;
  final double yaw;
  final double pitch;
  final double roll;
  final double
  normalizedSuspensionTravelFrontLeft; // Suspension travel normalized: 0.0f = max stretch; 1.0 = max compression
  final double normalizedSuspensionTravelFrontRight;
  final double normalizedSuspensionTravelRearLeft;
  final double normalizedSuspensionTravelRearRight;
  final double
  tireSlipRatioFrontLeft; // Tire normalized slip ratio, = 0 means 100% grip and |ratio| > 1.0 means loss of grip.
  final double tireSlipRatioFrontRight;
  final double tireSlipRatioRearLeft;
  final double tireSlipRatioRearRight;
  final double wheelRotationSpeedFrontLeft; // Wheel rotation speed radians/sec.
  final double wheelRotationSpeedFrontRight;
  final double wheelRotationSpeedRearLeft;
  final double wheelRotationSpeedRearRight;
  final int
  wheelOnRumbleStripFrontLeft; // = 1 when wheel is on rumble strip, = 0 when off.
  final int wheelOnRumbleStripFrontRight;
  final int wheelOnRumbleStripRearLeft;
  final int wheelOnRumbleStripRearRight;
  final double
  wheelInPuddleDepthFrontLeft; // = from 0 to 1, where 1 is the deepest puddle
  final double wheelInPuddleDepthFrontRight;
  final double wheelInPuddleDepthRearLeft;
  final double wheelInPuddleDepthRearRight;
  final double
  surfaceRumbleFrontLeft; // Non-dimensional surface rumble values passed to controller force feedback
  final double surfaceRumbleFrontRight;
  final double surfaceRumbleRearLeft;
  final double surfaceRumbleRearRight;
  final double
  tireSlipAngleFrontLeft; // Tire normalized slip angle, = 0 means 100% grip and |angle| > 1.0 means loss of grip.
  final double tireSlipAngleFrontRight;
  final double tireSlipAngleRearLeft;
  final double tireSlipAngleRearRight;
  final double
  tireCombinedSlipFrontLeft; // Tire normalized combined slip, = 0 means 100% grip and |slip| > 1.0 means loss of grip.
  final double tireCombinedSlipFrontRight;
  final double tireCombinedSlipRearLeft;
  final double tireCombinedSlipRearRight;
  final double
  suspensionTravelMetersFrontLeft; // Actual suspension travel in meters
  final double suspensionTravelMetersFrontRight;
  final double suspensionTravelMetersRearLeft;
  final double suspensionTravelMetersRearRight;
  final int carOrdinal; //Unique ID of the car make/model
  final int
  carClass; //Between 0 (D -- worst cars) and 7 (X class -- best cars) inclusive
  final int
  carPerformanceIndex; //Between 100 (slowest car) and 999 (fastest car) inclusive
  final int
  drivetrainType; //Corresponds to EDrivetrainType; 0 = FWD, 1 = RWD, 2 = AWD
  final int numCylinders; //Number of cylinders in the engine
  final double positionX;
  final double positionY;
  final double positionZ;
  final double speed; // meters per second
  final double power; // watts
  final double torque; // newton meter
  final double tireTempFrontLeft;
  final double tireTempFrontRight;
  final double tireTempRearLeft;
  final double tireTempRearRight;
  final double boost;
  final double fuel;
  final double distanceTraveled;
  final double bestLap;
  final double lastLap;
  final double currentLap;
  final double currentRaceTime;
  final int lapNumber;
  final int racePosition;
  final int acceleration;
  final int brake;
  final int clutch;
  final int handBrake;
  final int gear;
  final int steer;
  final int normalizedDrivingLine;
  final int normalizedAIBrakeDifference;

  Map<String, dynamic> get asMap => {'isRaceOn': isRaceOn, 'timestampMS': timestampMS, 'engineMaxRpm': engineMaxRpm, 'engineIdleRpm': engineIdleRpm, 'currentEngineRpm': currentEngineRpm, 'accelerationX': accelerationX, 'accelerationY': accelerationY, 'accelerationZ': accelerationZ, 'velocityX': velocityX, 'velocityY': velocityY, 'velocityZ': velocityZ, 'angularVelocityX': angularVelocityX, 'angularVelocityY': angularVelocityY, 'angularVelocityZ': angularVelocityZ, 'yaw': yaw, 'pitch': pitch, 'roll': roll, 'normalizedSuspensionTravelFrontLeft': normalizedSuspensionTravelFrontLeft, 'normalizedSuspensionTravelFrontRight': normalizedSuspensionTravelFrontRight, 'normalizedSuspensionTravelRearLeft': normalizedSuspensionTravelRearLeft, 'normalizedSuspensionTravelRearRight': normalizedSuspensionTravelRearRight, 'tireSlipRatioFrontLeft': tireSlipRatioFrontLeft, 'tireSlipRatioFrontRight': tireSlipRatioFrontRight, 'tireSlipRatioRearLeft': tireSlipRatioRearLeft, 'tireSlipRatioRearRight': tireSlipRatioRearRight, 'wheelRotationSpeedFrontLeft': wheelRotationSpeedFrontLeft, 'wheelRotationSpeedFrontRight': wheelRotationSpeedFrontRight, 'wheelRotationSpeedRearLeft': wheelRotationSpeedRearLeft, 'wheelRotationSpeedRearRight': wheelRotationSpeedRearRight, 'wheelOnRumbleStripFrontLeft': wheelOnRumbleStripFrontLeft, 'wheelOnRumbleStripFrontRight': wheelOnRumbleStripFrontRight, 'wheelOnRumbleStripRearLeft': wheelOnRumbleStripRearLeft, 'wheelOnRumbleStripRearRight': wheelOnRumbleStripRearRight, 'wheelInPuddleDepthFrontLeft': wheelInPuddleDepthFrontLeft, 'wheelInPuddleDepthFrontRight': wheelInPuddleDepthFrontRight, 'wheelInPuddleDepthRearLeft': wheelInPuddleDepthRearLeft, 'wheelInPuddleDepthRearRight': wheelInPuddleDepthRearRight, 'surfaceRumbleFrontLeft': surfaceRumbleFrontLeft, 'surfaceRumbleFrontRight': surfaceRumbleFrontRight, 'surfaceRumbleRearLeft': surfaceRumbleRearLeft, 'surfaceRumbleRearRight': surfaceRumbleRearRight, 'tireSlipAngleFrontLeft': tireSlipAngleFrontLeft, 'tireSlipAngleFrontRight': tireSlipAngleFrontRight, 'tireSlipAngleRearLeft': tireSlipAngleRearLeft, 'tireSlipAngleRearRight': tireSlipAngleRearRight, 'tireCombinedSlipFrontLeft': tireCombinedSlipFrontLeft, 'tireCombinedSlipFrontRight': tireCombinedSlipFrontRight, 'tireCombinedSlipRearLeft': tireCombinedSlipRearLeft, 'tireCombinedSlipRearRight': tireCombinedSlipRearRight, 'suspensionTravelMetersFrontLeft': suspensionTravelMetersFrontLeft, 'suspensionTravelMetersFrontRight': suspensionTravelMetersFrontRight, 'suspensionTravelMetersRearLeft': suspensionTravelMetersRearLeft, 'suspensionTravelMetersRearRight': suspensionTravelMetersRearRight, 'carOrdinal': carOrdinal, 'carClass': carClass, 'carPerformanceIndex': carPerformanceIndex, 'drivetrainType': drivetrainType, 'numCylinders': numCylinders, 'positionX': positionX, 'positionY': positionY, 'positionZ': positionZ, 'speed': speed, 'power': power, 'torque': torque, 'tireTempFrontLeft': tireTempFrontLeft, 'tireTempFrontRight': tireTempFrontRight, 'tireTempRearLeft': tireTempRearLeft, 'tireTempRearRight': tireTempRearRight, 'boost': boost, 'fuel': fuel, 'distanceTraveled': distanceTraveled, 'bestLap': bestLap, 'lastLap': lastLap, 'currentLap': currentLap, 'currentRaceTime': currentRaceTime, 'lapNumber': lapNumber, 'racePosition': racePosition, 'acceleration': acceleration, 'brake': brake, 'clutch': clutch, 'handBrake': handBrake, 'gear': gear, 'steer': steer, 'normalizedDrivingLine': normalizedDrivingLine, 'normalizedAIBrakeDifference': normalizedAIBrakeDifference};
  /// Single frame of UDP data from the game, contains every parameter
  ///
  /// Datagrams are sent sixty times a second, and always contain all parameters,
  /// therefore, a single object is used to pack all parameters.
  const HorizonDataFrame({
    required this.isRaceOn,
    required this.timestampMS,
    required this.engineMaxRpm,
    required this.engineIdleRpm,
    required this.currentEngineRpm,
    required this.accelerationX,
    required this.accelerationY,
    required this.accelerationZ,
    required this.velocityX,
    required this.velocityY,
    required this.velocityZ,
    required this.angularVelocityX,
    required this.angularVelocityY,
    required this.angularVelocityZ,
    required this.yaw,
    required this.pitch,
    required this.roll,
    required this.normalizedSuspensionTravelFrontLeft,
    required this.normalizedSuspensionTravelFrontRight,
    required this.normalizedSuspensionTravelRearLeft,
    required this.normalizedSuspensionTravelRearRight,
    required this.tireSlipRatioFrontLeft,
    required this.tireSlipRatioFrontRight,
    required this.tireSlipRatioRearLeft,
    required this.tireSlipRatioRearRight,
    required this.wheelRotationSpeedFrontLeft,
    required this.wheelRotationSpeedFrontRight,
    required this.wheelRotationSpeedRearLeft,
    required this.wheelRotationSpeedRearRight,
    required this.wheelOnRumbleStripFrontLeft,
    required this.wheelOnRumbleStripFrontRight,
    required this.wheelOnRumbleStripRearLeft,
    required this.wheelOnRumbleStripRearRight,
    required this.wheelInPuddleDepthFrontLeft,
    required this.wheelInPuddleDepthFrontRight,
    required this.wheelInPuddleDepthRearLeft,
    required this.wheelInPuddleDepthRearRight,
    required this.surfaceRumbleFrontLeft,
    required this.surfaceRumbleFrontRight,
    required this.surfaceRumbleRearLeft,
    required this.surfaceRumbleRearRight,
    required this.tireSlipAngleFrontLeft,
    required this.tireSlipAngleFrontRight,
    required this.tireSlipAngleRearLeft,
    required this.tireSlipAngleRearRight,
    required this.tireCombinedSlipFrontLeft,
    required this.tireCombinedSlipFrontRight,
    required this.tireCombinedSlipRearLeft,
    required this.tireCombinedSlipRearRight,
    required this.suspensionTravelMetersFrontLeft,
    required this.suspensionTravelMetersFrontRight,
    required this.suspensionTravelMetersRearLeft,
    required this.suspensionTravelMetersRearRight,
    required this.carOrdinal,
    required this.carClass,
    required this.carPerformanceIndex,
    required this.drivetrainType,
    required this.numCylinders,
    required this.positionX,
    required this.positionY,
    required this.positionZ,
    required this.speed,
    required this.power,
    required this.torque,
    required this.tireTempFrontLeft,
    required this.tireTempFrontRight,
    required this.tireTempRearLeft,
    required this.tireTempRearRight,
    required this.boost,
    required this.fuel,
    required this.distanceTraveled,
    required this.bestLap,
    required this.lastLap,
    required this.currentLap,
    required this.currentRaceTime,
    required this.lapNumber,
    required this.racePosition,
    required this.acceleration,
    required this.brake,
    required this.clutch,
    required this.handBrake,
    required this.gear,
    required this.steer,
    required this.normalizedDrivingLine,
    required this.normalizedAIBrakeDifference
  });


  static HorizonDataFrame createFrom(ByteData buffer) {
    assert (buffer.lengthInBytes >= expectedLength);
    return HorizonDataFrame(
        isRaceOn: buffer.getS32(0),
        timestampMS: buffer.getU32(4),
        engineMaxRpm: buffer.getF32(8),
        engineIdleRpm: buffer.getF32(12),
        currentEngineRpm: buffer.getF32(16),
        accelerationX: buffer.getF32(20),
        accelerationY: buffer.getF32(24),
        accelerationZ: buffer.getF32(28),
        velocityX: buffer.getF32(32),
        velocityY: buffer.getF32(36),
        velocityZ: buffer.getF32(40),
        angularVelocityX: buffer.getF32(44),
        angularVelocityY: buffer.getF32(48),
        angularVelocityZ: buffer.getF32(52),
        yaw: buffer.getF32(56),
        pitch: buffer.getF32(60),
        roll: buffer.getF32(64),
        normalizedSuspensionTravelFrontLeft: buffer.getF32(68),
        normalizedSuspensionTravelFrontRight: buffer.getF32(72),
        normalizedSuspensionTravelRearLeft: buffer.getF32(76),
        normalizedSuspensionTravelRearRight: buffer.getF32(80),
        tireSlipRatioFrontLeft: buffer.getF32(84),
        tireSlipRatioFrontRight: buffer.getF32(88),
        tireSlipRatioRearLeft: buffer.getF32(92),
        tireSlipRatioRearRight: buffer.getF32(96),
        wheelRotationSpeedFrontLeft: buffer.getF32(100),
        wheelRotationSpeedFrontRight: buffer.getF32(104),
        wheelRotationSpeedRearLeft: buffer.getF32(108),
        wheelRotationSpeedRearRight: buffer.getF32(112),
        wheelOnRumbleStripFrontLeft: buffer.getS32(116),
        wheelOnRumbleStripFrontRight: buffer.getS32(120),
        wheelOnRumbleStripRearLeft: buffer.getS32(124),
        wheelOnRumbleStripRearRight: buffer.getS32(128),
        wheelInPuddleDepthFrontLeft: buffer.getF32(132),
        wheelInPuddleDepthFrontRight: buffer.getF32(136),
        wheelInPuddleDepthRearLeft: buffer.getF32(140),
        wheelInPuddleDepthRearRight: buffer.getF32(144),
        surfaceRumbleFrontLeft: buffer.getF32(148),
        surfaceRumbleFrontRight: buffer.getF32(152),
        surfaceRumbleRearLeft: buffer.getF32(156),
        surfaceRumbleRearRight: buffer.getF32(160),
        tireSlipAngleFrontLeft: buffer.getF32(164),
        tireSlipAngleFrontRight: buffer.getF32(168),
        tireSlipAngleRearLeft: buffer.getF32(172),
        tireSlipAngleRearRight: buffer.getF32(176),
        tireCombinedSlipFrontLeft: buffer.getF32(180),
        tireCombinedSlipFrontRight: buffer.getF32(184),
        tireCombinedSlipRearLeft: buffer.getF32(188),
        tireCombinedSlipRearRight: buffer.getF32(192),
        suspensionTravelMetersFrontLeft: buffer.getF32(196),
        suspensionTravelMetersFrontRight: buffer.getF32(200),
        suspensionTravelMetersRearLeft: buffer.getF32(204),
        suspensionTravelMetersRearRight: buffer.getF32(208),
        carOrdinal: buffer.getS32(212),
        carClass: buffer.getS32(216),
        carPerformanceIndex: buffer.getS32(220),
        drivetrainType: buffer.getS32(224),
        numCylinders: buffer.getS32(228),
        positionX: buffer.getF32(244),
        positionY: buffer.getF32(248),
        positionZ: buffer.getF32(252),
        speed: buffer.getF32(256),
        power: buffer.getF32(260),
        torque: buffer.getF32(264),
        tireTempFrontLeft: buffer.getF32(268),
        tireTempFrontRight: buffer.getF32(272),
        tireTempRearLeft: buffer.getF32(276),
        tireTempRearRight: buffer.getF32(280),
        boost: buffer.getF32(284),
        fuel: buffer.getF32(288),
        distanceTraveled: buffer.getF32(292),
        bestLap: buffer.getF32(296),
        lastLap: buffer.getF32(300),
        currentLap: buffer.getF32(304),
        currentRaceTime: buffer.getF32(308),
        lapNumber: buffer.getU16(312),
        racePosition: buffer.getUint8(314),
        acceleration: buffer.getUint8(315),
        brake: buffer.getUint8(316),
        clutch: buffer.getUint8(317),
        handBrake: buffer.getUint8(318),
        gear: buffer.getUint8(319),
        steer: buffer.getS8(320),
        normalizedDrivingLine: buffer.getS8(321),
        normalizedAIBrakeDifference: buffer.getS8(322)
    );
  }

  @override
  String toString() => 'Frame(isRaceOn: $isRaceOn, timestampMS: $timestampMS, engineMaxRpm: $engineMaxRpm, engineIdleRpm: $engineIdleRpm, currentEngineRpm: $currentEngineRpm, accelerationX: $accelerationX, accelerationY: $accelerationY, accelerationZ: $accelerationZ, velocityX: $velocityX, velocityY: $velocityY, velocityZ: $velocityZ, angularVelocityX: $angularVelocityX, angularVelocityY: $angularVelocityY, angularVelocityZ: $angularVelocityZ, yaw: $yaw, pitch: $pitch, roll: $roll, normalizedSuspensionTravelFrontLeft: $normalizedSuspensionTravelFrontLeft, normalizedSuspensionTravelFrontRight: $normalizedSuspensionTravelFrontRight, normalizedSuspensionTravelRearLeft: $normalizedSuspensionTravelRearLeft, normalizedSuspensionTravelRearRight: $normalizedSuspensionTravelRearRight, tireSlipRatioFrontLeft: $tireSlipRatioFrontLeft, tireSlipRatioFrontRight: $tireSlipRatioFrontRight, tireSlipRatioRearLeft: $tireSlipRatioRearLeft, tireSlipRatioRearRight: $tireSlipRatioRearRight, wheelRotationSpeedFrontLeft: $wheelRotationSpeedFrontLeft, wheelRotationSpeedFrontRight: $wheelRotationSpeedFrontRight, wheelRotationSpeedRearLeft: $wheelRotationSpeedRearLeft, wheelRotationSpeedRearRight: $wheelRotationSpeedRearRight, wheelOnRumbleStripFrontLeft: $wheelOnRumbleStripFrontLeft, wheelOnRumbleStripFrontRight: $wheelOnRumbleStripFrontRight, wheelOnRumbleStripRearLeft: $wheelOnRumbleStripRearLeft, wheelOnRumbleStripRearRight: $wheelOnRumbleStripRearRight, wheelInPuddleDepthFrontLeft: $wheelInPuddleDepthFrontLeft, wheelInPuddleDepthFrontRight: $wheelInPuddleDepthFrontRight, wheelInPuddleDepthRearLeft: $wheelInPuddleDepthRearLeft, wheelInPuddleDepthRearRight: $wheelInPuddleDepthRearRight, surfaceRumbleFrontLeft: $surfaceRumbleFrontLeft, surfaceRumbleFrontRight: $surfaceRumbleFrontRight, surfaceRumbleRearLeft: $surfaceRumbleRearLeft, surfaceRumbleRearRight: $surfaceRumbleRearRight, tireSlipAngleFrontLeft: $tireSlipAngleFrontLeft, tireSlipAngleFrontRight: $tireSlipAngleFrontRight, tireSlipAngleRearLeft: $tireSlipAngleRearLeft, tireSlipAngleRearRight: $tireSlipAngleRearRight, tireCombinedSlipFrontLeft: $tireCombinedSlipFrontLeft, tireCombinedSlipFrontRight: $tireCombinedSlipFrontRight, tireCombinedSlipRearLeft: $tireCombinedSlipRearLeft, tireCombinedSlipRearRight: $tireCombinedSlipRearRight, suspensionTravelMetersFrontLeft: $suspensionTravelMetersFrontLeft, suspensionTravelMetersFrontRight: $suspensionTravelMetersFrontRight, suspensionTravelMetersRearLeft: $suspensionTravelMetersRearLeft, suspensionTravelMetersRearRight: $suspensionTravelMetersRearRight, carOrdinal: $carOrdinal, carClass: $carClass, carPerformanceIndex: $carPerformanceIndex, drivetrainType: $drivetrainType, numCylinders: $numCylinders, positionX: $positionX, positionY: $positionY, positionZ: $positionZ, speed: $speed, power: $power, torque: $torque, tireTempFrontLeft: $tireTempFrontLeft, tireTempFrontRight: $tireTempFrontRight, tireTempRearLeft: $tireTempRearLeft, tireTempRearRight: $tireTempRearRight, boost: $boost, fuel: $fuel, distanceTraveled: $distanceTraveled, bestLap: $bestLap, lastLap: $lastLap, currentLap: $currentLap, currentRaceTime: $currentRaceTime, lapNumber: $lapNumber, racePosition: $racePosition, acceleration: $acceleration, brake: $brake, clutch: $clutch, handBrake: $handBrake, gear: $gear, steer: $steer, normalizedDrivingLine: $normalizedDrivingLine, normalizedAIBrakeDifference: $normalizedAIBrakeDifference)';
}
