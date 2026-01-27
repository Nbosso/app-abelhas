class AffectedBeehive {
  final String beehiveId;
  final String apicultorId;
  final double distanceMeters;
  final int beehiveRadius;
  final int totalRiskRadius;

  const AffectedBeehive({
    required this.beehiveId,
    required this.apicultorId,
    required this.distanceMeters,
    required this.beehiveRadius,
    required this.totalRiskRadius,
  });

  factory AffectedBeehive.fromMap(Map<String, dynamic> map) {
    return AffectedBeehive(
      beehiveId: map['beehive_id'].toString(),
      apicultorId: map['apicultor_id'].toString(),
      distanceMeters: (map['distance_meters'] as num).toDouble(),
      beehiveRadius: (map['beehive_radius'] as num).toInt(),
      totalRiskRadius: (map['total_risk_radius'] as num).toInt(),
    );
  }

  @override
  String toString() {
    return 'AffectedBeehive('
        'beehiveId: $beehiveId, '
        'apicultorId: $apicultorId, '
        'distanceMeters: $distanceMeters, '
        'beehiveRadius: $beehiveRadius, '
        'totalRiskRadius: $totalRiskRadius'
        ')';
  }
}
