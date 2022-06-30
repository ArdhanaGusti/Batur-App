import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:theme/theme.dart';
import 'package:transportation/presentation/screens/timeline_screen.dart';

class CustomSecondaryContainerDetail extends StatelessWidget {
  // Add Parameter Data Train
  final String title;
  final double width;
  final bool isTrain;
  final String station;
  const CustomSecondaryContainerDetail(
      {Key? key,
      required this.width,
      required this.isTrain,
      required this.title,
      required this.station})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(station);
    return Container(
      width: width,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).colorScheme.secondaryContainer,
        boxShadow: const [
          BoxShadow(
            color: bStroke,
            spreadRadius: 2.0,
            blurRadius: 10.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            maxLines: 1,
            style: bHeading7.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: (isTrain)
                  ? FirebaseFirestore.instance
                      .collection("Train")
                      .where("station", isEqualTo: station)
                      // .orderBy('date', descending: false)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection("Bus")
                      .where("transit", isEqualTo: station)
                      // .orderBy('date', descending: false)
                      .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var trans = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    // Use Data
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              curve: Curves.easeInOut,
                              type: PageTransitionType.rightToLeft,
                              // Add parameter Train
                              child: TimeLineScreen(
                                name: (isTrain)
                                    ? trans[index]['trainName']
                                    : trans[index]['name'],
                                isTrain: isTrain,
                              ),
                              duration: const Duration(milliseconds: 150),
                              reverseDuration:
                                  const Duration(milliseconds: 150),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    // Data Train
                                    (isTrain)
                                        ? trans[index]['trainName']
                                        : trans[index]['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: bSubtitle4.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    // Data Train
                                    "Rp.25.000",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: bSubtitle4.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              // Data Train
                              (isTrain)
                                  ? trans[index]['station']
                                  : trans[index]['transit'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: bCaption1.copyWith(color: bGrey),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        // Data Train
                                        "BDG",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: bCaption3.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                      ),
                                      Text(
                                        // Data Train
                                        "${trans[index]['date'].toDate().hour.toString().padLeft(2, '0')}:${trans[index]['date'].toDate().minute.toString().padLeft(2, '0')}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: bCaption1.copyWith(color: bGrey),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    // Data Train
                                    // Proces the data
                                    "1 Jam 5 Menit",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: bCaption1.copyWith(color: bGrey),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        // Data Train
                                        "BDG",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: bCaption3.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ),
                                      ),
                                      Text(
                                        // Data Train
                                        "14.50",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: bCaption1.copyWith(color: bGrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: trans.length,
                );
              }),
        ],
      ),
    );
  }
}
