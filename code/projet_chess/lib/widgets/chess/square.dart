import 'package:flutter/material.dart';
import 'package:projet_chess/widgets/chess/pieces.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  final bool isSelected;
  final bool isValideMove;
  final ChessPiece? piece;
  final void Function() onTap;
  static var backgroundColor = const Color(0xff91908e);
  static var foregroundColor = const Color(0xff6f6e6c);

  const Square(
      {super.key,
      required this.isWhite,
      required this.piece,
      required this.isSelected,
      required this.onTap,
      required this.isValideMove});

  @override
  Widget build(BuildContext context) {
    Color? squareColor;
    BoxBorder? boxBorder;

    if (isSelected) {
      squareColor = Colors.grey;
      boxBorder = Border.all(color: Colors.black.withOpacity(1), width: 0.03);
    } else if (isValideMove) {
      squareColor = Colors.green.withOpacity(1);
      boxBorder = Border.all(color: Colors.black.withOpacity(1), width: 0.03);
    } else {
      squareColor = isWhite ? foregroundColor : backgroundColor;
      boxBorder =
          Border.all(color: Colors.black.withOpacity(0.5), width: 0.001);
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(color: squareColor, border: boxBorder),
        child: piece != null
            ? Center(
                child: SizedBox(
                    height: 40,
                    child: Image.asset(
                      piece!.imagePath,
                      color: Colors.black,
                    )))
            : null,
      ),
    );
  }
}
