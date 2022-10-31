abstract class CardInfo {
  final String id;
  final String url;
  final bool isActive;

  const CardInfo({
    required this.id,
    required this.url,
    this.isActive = false,
  });

  bool isSameCard(CardInfo other) => id == other.id;

  CardInfo copyWith({
    String? id,
    String? url,
    bool? isActive,
  });

  @override
  String toString() => 'CardInfo(id: $id, url: $url, isActive: $isActive)';
}

class CardInfoNetwork extends CardInfo {
  const CardInfoNetwork({
    required super.id,
    required super.url,
    super.isActive = false,
  });

  @override
  CardInfo copyWith({String? id, String? url, bool? isActive}) {
    return CardInfoNetwork(
      id: id ?? this.id,
      url: url ?? this.url,
      isActive: isActive ?? this.isActive,
    );
  }
}

class CardInfoAsset extends CardInfo {
  const CardInfoAsset({
    super.id = '',
    super.url = 'assets/images/star.svg',
    super.isActive = false,
  });

  @override
  CardInfo copyWith({String? id, String? url, bool? isActive}) {
    return CardInfoAsset(
      id: id ?? this.id,
      url: url ?? this.url,
      isActive: isActive ?? this.isActive,
    );
  }
}
