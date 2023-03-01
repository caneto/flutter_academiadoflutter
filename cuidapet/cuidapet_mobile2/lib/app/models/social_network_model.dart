class SocialNetworkModel {
  final String id;
  final String name;
  final String email;
  final String type;
  final String accessToken;
  final String? avatar;

  const SocialNetworkModel({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.accessToken,
    this.avatar,
  });
}
