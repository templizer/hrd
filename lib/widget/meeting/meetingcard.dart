import 'package:cnattendance/data/source/network/model/meeting/Participator.dart';
import 'package:cnattendance/screen/profile/meetingdetailscreen.dart';
import 'package:cnattendance/widget/meeting/meetingparticipator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class MeetingCard extends StatelessWidget {
  final int id;
  final String title;
  final String venue;
  final String date;
  final List<Participator> participator;

  MeetingCard(this.id, this.title, this.venue, this.date, this.participator);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(MeetingDetailScreen(),arguments: {"id":id});
      },
      child: Card(
        color: Colors.white12,
        elevation: 0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 10.0, right: 100.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${translate('meeting_list_screen.venue')} : ${venue}',
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      date,
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: participator.length <= 3
                                ? participator.length
                                : 3,
                            itemBuilder: (context, index) {
                              return MeetingParticipator(
                                  participator[index].avatar);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Visibility(
                            visible: participator.length <= 3 ? false : true,
                            child: Text(
                              '+${participator.length - 3} more',
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  'assets/icons/meeting.svg',
                  width: 80,
                  height: 80,
                  color: Colors.white10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
