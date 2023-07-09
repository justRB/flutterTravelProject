import 'package:flutter/material.dart';
import 'package:flutter_travel_project/models/publication_class.dart';

class PublicationCard extends StatefulWidget {
  final PublicationClass publicationObject;

  const PublicationCard({
    required this.publicationObject,
    super.key,
  });

  @override
  State<PublicationCard> createState() => _PublicationCardState();
}

class _PublicationCardState extends State<PublicationCard> {
  int maxLine = 3;
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = widget.publicationObject.date.toDate();
    String formattedDateTime = '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(top: 35),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(widget.publicationObject.imageHttp!),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                    ),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.publicationObject.score.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                            ),
                          ),
                          const Icon(
                            Icons.star,
                            size: 15,
                            color: Color.fromARGB(255, 255, 209, 59),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 5),
              child: Column(
                children: [
                  Text(
                    widget.publicationObject.comment,
                    maxLines: maxLine,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/avatar.png', width: 25),
                          const SizedBox(width: 5),
                          Text(
                            widget.publicationObject.author,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color.fromARGB(175, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            formattedDateTime,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Color.fromARGB(197, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          maxLine = (maxLine == 3) ? 10 : 3;
        });
      },
    );
  }
}
