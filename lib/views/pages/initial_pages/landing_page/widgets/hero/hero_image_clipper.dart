import 'package:anyamar/commons/exports.dart';

// class HeroImageClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     return Path()
//       ..moveTo(size.width * 0.20, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width * 0.32, size.height)
//       ..cubicTo(
//         size.width * 0.17,
//         size.height * 0.78,
//         size.width * 0.04,
//         size.height * 0.62,
//         size.width * 0.10,
//         size.height * 0.43,
//       )
//       ..lineTo(size.width * 0.20, 0)
//       ..close();
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }

// class HeroImageClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     return Path()
//       ..moveTo(size.width * 0.32, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width * 0.30, size.height)
//       ..lineTo(size.width * 0.08, size.height * 0.48)
//       ..close();
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }

// class HeroImageClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     return Path()
//       ..moveTo(size.width * 0.20, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width * 0.32, size.height)
//       ..lineTo(size.width * 0.12, size.height * 0.65)
//       ..lineTo(size.width * 0.06, size.height * 0.52)
//       ..lineTo(size.width * 0.10, size.height * 0.38)
//       ..lineTo(size.width * 0.20, 0)
//       ..close();
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }

// class HeroImageClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     return Path()
//       // Top-left: image starts 30% across the width
//       ..moveTo(size.width * 0.30, 0)
//       // Top-right
//       ..lineTo(size.width, 0)
//       // ..lineTo(size.width * 0.50, 0)
//       // ..lineTo(size.width * 0.30, size.height)
//       // Bottom-right
//       ..lineTo(size.width, size.height)
//       // Bottom-left: wider at the bottom
//       ..lineTo(size.width * 0.12, size.height)
//       // Close the trapezoid
//       ..close();
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }
// class HeroImageClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     return Path()
//       ..moveTo(size.width * 0.42, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width * 0.08, size.height)
//       ..lineTo(size.width * 0.22, size.height * 0.50)
//       ..close();
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }
// class HeroImageClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();

//     path
//       ..moveTo(size.width * 0.35, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(size.width * 0.35, size.height)
//       ..cubicTo(
//         size.width * -0.05,
//         size.height * 0.75,
//         size.width * -0.05,
//         size.height * 0.25,
//         size.width * 0.35,
//         0,
//       )
//       ..close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant HeroImageClipper oldClipper) => false;
// }
class HeroImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width * 0.48, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.48, size.height)
      ..cubicTo(
        size.width * 0.18,
        size.height * 0.75,
        size.width * 0.18,
        size.height * 0.25,
        size.width * 0.48,
        0,
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant HeroImageClipper oldClipper) => false;
}
// class TopLeftWaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     return Path()
//       ..moveTo(size.width * 0.30, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(0, size.height)
//       ..lineTo(0, size.height * 0.30)
//       ..cubicTo(
//         size.width * 0.05,
//         size.height * 0.15,
//         size.width * 0.12,
//         size.height * 0.05,
//         size.width * 0.30,
//         0,
//       )
//       ..close();
//   }

//   @override
//   bool shouldReclip(covariant TopLeftWaveClipper oldClipper) => false;
// }
// class TopLeftWaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     return Path()
//       // Start along the top edge
//       ..moveTo(size.width * 0.10, 0)
//       ..lineTo(size.width, 0)
//       ..lineTo(size.width, size.height)
//       ..lineTo(0, size.height)
//       ..lineTo(0, size.height * 0.28)
//       // Create the wave connecting the left and top edges
//       ..cubicTo(
//         size.width * 0.08,
//         size.height * 0.28,
//         size.width * 0.08,
//         size.height * 0.02,
//         size.width * 0.28,
//         0,
//       )
//       ..close();
//   }

//   @override
//   bool shouldReclip(covariant TopLeftWaveClipper oldClipper) => false;
// }
class TopLeftWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const waveWidth = 0.20;
    const waveHeight = 0.20;

    return Path()
      ..moveTo(size.width * waveWidth, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, size.height * waveHeight)
      ..cubicTo(
        size.width * 0.06,
        size.height * 0.2,
        size.width * 0.06,
        size.height * 0.06,
        size.width * waveWidth,
        0,
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant TopLeftWaveClipper oldClipper) => false;
}
