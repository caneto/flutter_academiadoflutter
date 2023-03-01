enum SocialLoginType {
  facebook('Facebook', 'facebook.com'),
  google('Google', 'google.com');

  final String value;
  final String domain;

  const SocialLoginType(this.value, this.domain);
}
