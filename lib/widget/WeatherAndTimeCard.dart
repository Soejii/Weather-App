import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatTimeCard extends StatefulWidget {
  const WeatTimeCard({
    Key? key,
    required this.time,
    required this.degrees,    required this.url,

  }) : super(key: key);

  final String time;
  final String degrees;
  final String url;
  @override
  State<WeatTimeCard> createState() => _WeatTimeCardState();
}

class _WeatTimeCardState extends State<WeatTimeCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.time,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            Container(
              width: 50,
              height: 50,
            child: Image.network(widget.url),
            ),
            Text(
              widget.degrees,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
