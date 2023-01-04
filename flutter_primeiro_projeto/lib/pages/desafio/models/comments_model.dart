class Comments {
  String authorName;
  String authorImageUrl;
  String text;

  Comments({
    required this.authorName,
    required this.authorImageUrl,
    required this.text,
  });
}

final List<Comments> comments = [
  Comments(
    authorName: 'Tim Cook',
    authorImageUrl: 'assets/images/user4.jpeg',
    text: 'Cool!',
  ),
  Comments(
    authorName: 'Miranda',
    authorImageUrl: 'assets/images/user1.jpeg',
    text: 'Cool!',
  ),
  Comments(
    authorName: 'Ingrid Broun',
    authorImageUrl: 'assets/images/user2.jpeg',
    text: 'Cool!',
  ),
  Comments(
    authorName: 'Addy Rock',
    authorImageUrl: 'assets/images/user3.jpeg',
    text: 'Cool!',
  ),
  Comments(
    authorName: 'Fill G',
    authorImageUrl: 'assets/images/user0.jpeg',
    text: 'Cool!',
  ),
];
