import 'package:exercicio_07/comment.dart';
import 'package:exercicio_07/post.dart';
import 'package:exercicio_07/user.dart';

class PostWithUser {
  final Post post;
  final User user;

  const PostWithUser({
    required this.post,
    required this.user,
  });
}
