import 'package:flutter/material.dart';

class PublicationCard extends StatefulWidget {
  final String authorFirstname;
  final String authorLastName;
  final String imageUrl;
  final String comment;
  final String date;
  final double score;

  const PublicationCard({
    required this.authorFirstname,
    required this.authorLastName,
    required this.imageUrl,
    required this.comment,
    required this.date,
    required this.score,
    super.key,
  });

  @override
  State<PublicationCard> createState() => _PublicationCardState();
}

class _PublicationCardState extends State<PublicationCard> {
  int maxLine = 8;
  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset('assets/${widget.imageUrl}'),
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
                            widget.score.toString(),
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
                    "\"${widget.comment}\"",
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
                            "${widget.authorFirstname} ${widget.authorLastName}",
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
                            widget.date,
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
          maxLine = (maxLine == 8) ? 100 : 8;
        });
      },
    );
  }
}
