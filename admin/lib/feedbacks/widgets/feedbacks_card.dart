
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:feedo_repository/feedo_repository.dart';
class FeedbacksCard extends StatelessWidget {
  final Feedbacks feedback;
  const FeedbacksCard({Key? key, required this.feedback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReadMoreText(
            '''
                Date ︲ ${feedback.time.toString().substring(0, feedback.time.toString().indexOf(" "))}
                Time ︲${feedback.time.toString().substring(10, feedback.time.toString().indexOf("."))}
                Condition ︲ ${feedback.condition}
                Branch ︲ ${feedback.branch}
                Name ︲ ${feedback.name}
                Phone ︲ ${feedback.number} 
                Questions No. ︲ ${feedback.questions.map((e) => e.quesNum)}
                Feedbacks ︲ ${feedback.questions.map((e) => e.feedback)}         
                ''',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: feedback.condition == "Major"
                  ? Colors.black.withOpacity(0.6)
                  : Colors.blueGrey.shade900,
            ),
            textDirection: TextDirection.rtl,
            trimLines: 5,
            colorClickableText: const Color(0xffED1846),
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            moreStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const Divider(
            endIndent: 40,
            indent: 40,
            color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
