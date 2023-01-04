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

class Stories {
  String user;
  String userAvatar;
  
  Stories({
    required this.user,
    required this.userAvatar,
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

final List<Stories> stories = [
  Stories(
    user: 'Women 1', 
    userAvatar: 'assets/images/user1.jpeg',
  ),
  Stories(
    user: 'Woman 2', 
    userAvatar: 'assets/images/user2.jpeg',
  ),
  Stories(
    user: 'Man 3', 
    userAvatar: 'assets/images/user3.jpeg',
  ),
  Stories(
    user: 'Man 4', 
    userAvatar: 'assets/images/user4.jpeg',
  ),
  Stories(
    user: 'Man 0', 
    userAvatar: 'assets/images/user0.jpeg',
  ),
  Stories(
    user: 'Women 1', 
    userAvatar: 'assets/images/user1.jpeg',
  ),
  Stories(
    user: 'Woman 2', 
    userAvatar: 'assets/images/user2.jpeg',
  ),
  Stories(
    user: 'Man 3', 
    userAvatar: 'assets/images/user3.jpeg',
  ),
];
