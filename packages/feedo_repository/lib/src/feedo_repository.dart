import 'package:feedo_repository/src/models/feedbacks.dart';

abstract class FeedoRepository {
  Future<void> addNewFeedback(Feedbacks feedback);

  Future<void> deleteFeedback(Feedbacks feedback);

  Stream<List<Feedbacks>> feedbacks();
  // Stream<List<Feedbacks>> updatedfeedbacks();


  Future<void> updateTodo(Feedbacks feedback);
}
