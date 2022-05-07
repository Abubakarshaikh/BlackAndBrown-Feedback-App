import 'package:feedo_repository/feedo_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const _delay = Duration(milliseconds: 150);

class FirebaseFeedoRepository implements FeedoRepository {
  final feedoCollection = FirebaseFirestore.instance.collection('user');
  @override
  Future<void> addNewFeedback(Feedbacks feedback) {
    return feedoCollection
        .doc(feedback.id)
        .set((feedback.toEntity().toDocument()));
  }

  @override
  Future<void> deleteFeedback(Feedbacks feedback) async {
    return feedoCollection.doc(feedback.id).delete();
  }

  @override
  Stream<List<Feedbacks>> feedbacks() {
    return feedoCollection
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((docs) {
        return Feedbacks.fromEntity(FeedbacksEntity.fromSnapshot(docs));
      }).toList();
    });
  }

  // @override
  // Stream<List<Feedbacks>> updatedfeedbacks(){}

  @override
  Future<void> updateTodo(Feedbacks feedback) async {}

  Future<List<Branch>> lodBranches() => Future.delayed(_delay, () => _branches);
  Future<List<Question>> loadQuestions() =>
      Future.delayed(_delay, () => _questions);
}

const List<Branch> _branches = [
  Branch(branchName: "AUTOBAHN", isChecked: true),
  Branch(branchName: "HAIDER CHOWK", isChecked: true),
  Branch(branchName: "WADHU WAH", isChecked: true),
  Branch(branchName: "GARRISON QASIM CHOWK", isChecked: true),
  Branch(branchName: "LATIFABAD UNIT 7", isChecked: true),
  Branch(branchName: "MAIN QASIMABAD", isChecked: true),
  Branch(branchName: "GYMKHANA", isChecked: true),
  Branch(branchName: "NASEEM NAGAR", isChecked: true),
  Branch(branchName: "SADDAR 1", isChecked: true),
  Branch(branchName: "HIRABAD", isChecked: true),
  Branch(branchName: "AUTOBAHN 2", isChecked: true),
  Branch(branchName: "LATIFABAD UNIT 9", isChecked: true),
  Branch(branchName: "SADDAR 2", isChecked: true),
  Branch(branchName: "ALAMDAR CHOWK", isChecked: true),
  Branch(branchName: "AFANDI TOWN", isChecked: true),
];

const List<Question> _questions = [
  Question(quesNum: 1, ques: "Are you satisfied with the services?"),
  Question(
      quesNum: 2,
      ques: "Are you satisfied with the atmosphere and cleanliess?"),
  Question(
      quesNum: 3,
      ques: "Do you like our products in terms of taste & appearance?"),
  Question(
      quesNum: 4,
      ques: "Are you satisfied with the behavior & Attitude of our employes?"),
  Question(quesNum: 5, ques: "Do you like the grooming of our staff members?"),
  Question(quesNum: 6, ques: "Will you recommend our products to others?"),
  Question(quesNum: 7, ques: "Mention if anythings needs to be improved?"),
  Question(quesNum: 8, ques: "Rate us out of 10?", feedback: '10/10'),
];
