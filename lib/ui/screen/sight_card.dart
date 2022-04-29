import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/presets/styles/text_styles.dart';

class SightCard extends StatefulWidget {
  final Sight cardSign;
  const SightCard({Key? key, required this.cardSign}) : super(key: key);

  @override
  State<SightCard> createState() => _SightCardState();
}

class _SightCardState extends State<SightCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/details', arguments: widget.cardSign);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(245, 245, 245, 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 96,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.cardSign.url),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child:
                      Text(widget.cardSign.type, style: AppTextStyles.button),
                ),
                Positioned(
                  top: 19,
                  right: 18,
                  height: 18,
                  width: 20,
                  child: IconButton(
                    icon: Icon(
                      widget.cardSign.liked
                          ? Icons.favorite_outlined
                          : Icons.favorite_outline_sharp,
                    ),
                    color: widget.cardSign.liked ? Colors.blue : Colors.white,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      widget.cardSign.liked = !widget.cardSign.liked;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.cardSign.name,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: AppTextStyles.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.cardSign.details,
                textAlign: TextAlign.left,
                style: AppTextStyles.small,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
