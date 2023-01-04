class Posts {
  String user;
  String userAvatar;
  String timeAgo;
  String imageUrl;

  Posts({
    required this.user,
    required this.userAvatar,
    required this.timeAgo,
    required this.imageUrl,
  });
}

final List<Posts> posts = [
  Posts(
    user: 'Maggie Wood',
    userAvatar: 'assets/images/post_image1.jpeg',
    timeAgo: '10 min',
    imageUrl: 'assets/images/post_image1.jpeg',
  ),
  Posts(
    user: 'Gas Markovsky',
    userAvatar: 'assets/images/post_image0.jpeg',
    timeAgo: '20 min',
    imageUrl: 'assets/images/post_image0.jpeg',
  ),
  Posts(
    user: 'Maggie Wood',
    userAvatar: 'assets/images/post_image1.jpeg',
    timeAgo: '10 min',
    imageUrl: 'assets/images/post_image1.jpeg',
  ),
];

final List<String> stories = [
  'assets/images/user1.jpeg',
  'assets/images/user2.jpeg',
  'assets/images/user3.jpeg',
  'assets/images/user4.jpeg',
  'assets/images/user0.jpeg',
  'assets/images/user1.jpeg',
  'assets/images/user2.jpeg',
  'assets/images/user3.jpeg',
];
