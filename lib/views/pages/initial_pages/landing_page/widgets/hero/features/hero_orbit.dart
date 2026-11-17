import 'dart:math' as math;
import 'package:anyamar/commons/exports.dart';

class FeatureOrbitIllustration extends ConsumerStatefulWidget {
  const FeatureOrbitIllustration({super.key});

  @override
  ConsumerState<FeatureOrbitIllustration> createState() =>
      _FeatureOrbitIllustrationState();
}

class _FeatureOrbitIllustrationState
    extends ConsumerState<FeatureOrbitIllustration>
    with TickerProviderStateMixin {
  late AnimationController _orbitController;
  late AnimationController _pulseController;
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = ref.watch(themeIsDarkProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        final dimension = math.min(constraints.maxWidth, constraints.maxHeight);

        return SizedBox(
          width: dimension,
          height: dimension,
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _orbitController,
              _pulseController,
              _floatController,
            ]),
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  //================================
                  // Orbital rings and particles
                  //================================
                  Positioned.fill(
                    child: CustomPaint(
                      painter: OrbitPainter(
                        rotation: _orbitController.value * 2 * math.pi,
                        pulse: _pulseController.value,
                      ),
                    ),
                  ),

                  //================================
                  // Feature nodes
                  //================================
                  _positionFeature(
                    // Alignment.topCenter,
                    const Alignment(0.0, -0.68),
                    Icons.apartment_rounded,
                    'Properties',
                    0,
                    isDarkMode,
                  ),

                  _positionFeature(
                    // const Alignment(0.87, -0.48),
                    const Alignment(0.87, -0.38),
                    Icons.people_alt_rounded,
                    'Tenants',
                    0.8,
                    isDarkMode,
                  ),

                  _positionFeature(
                    const Alignment(0.87, 0.38),
                    Icons.grid_view_rounded,
                    'Units',
                    1.6,
                    isDarkMode,
                  ),

                  _positionFeature(
                    // Alignment.bottomCenter,
                    const Alignment(0.0, 0.68),
                    Icons.payments_rounded,
                    'Rent Collection',
                    2.4,
                    isDarkMode,
                  ),

                  _positionFeature(
                    const Alignment(-0.87, 0.38),
                    Icons.bar_chart_rounded,
                    'Financial Reports',
                    3.2,
                    isDarkMode,
                  ),

                  _positionFeature(
                    // const Alignment(-0.87, -0.48),
                    const Alignment(-0.87, -0.38),
                    Icons.analytics_rounded,
                    'Analytics',
                    4.0,
                    isDarkMode,
                  ),

                  //================================
                  // Central illustration
                  //================================
                  _buildCenterIllustration(isDarkMode),
                ],
              );
            },
          ),
        );
      },
    );
  }

  //========================================
  // Feature positioning
  //========================================

  Widget _positionFeature(
    Alignment alignment,
    IconData icon,
    String title,
    double phase,
    bool isDarkMode,
  ) {
    final movement = math.sin((_floatController.value * math.pi) + phase) * 5;

    return Align(
      alignment: alignment,
      child: Transform.translate(
        offset: Offset(0, movement),
        child: FeatureNode(icon: icon, title: title),
      ),
    );
  }

  //========================================
  // Central building illustration
  //========================================

  Widget _buildCenterIllustration(bool isDarkMode) {
    final glow = 15 + (_pulseController.value * 15);

    return Container(
      width: 155,
      height: 155,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: isDarkMode
              ? [Color(0xFF263D82), Color(0xFF111A40), Color(0xFF090D25)]
              : [
                  AppColors.lightCard,
                  AppColorsConstant.kPrimaryColor,
                  AppColors.darkText,
                ],
        ),
        border: Border.all(
          color: AppColors.primaryBlue.withValues(alpha: 0.8),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.25),
            blurRadius: glow,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: const Color(0xFF8A45FF).withValues(alpha: 0.15),
            blurRadius: 35,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.roofing_rounded,
            color: AppColors.primaryBlue,
            size: 55,
            shadows: [Shadow(color: Color(0xFF299EFF), blurRadius: 25)],
          ),

          const SizedBox(height: 5),

          Text(
            'ANYAMAR',
            style: TextStyle(
              color: isDarkMode ? Colors.white : AppColors.lightText,
              fontWeight: FontWeight.w800,
              fontSize: 13,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

//============================================
// Custom orbital painter
//============================================

class OrbitPainter extends CustomPainter {
  final double rotation;
  final double pulse;

  OrbitPainter({required this.rotation, required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = size.width * 0.33;

    // Main orbital ring
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..shader = const LinearGradient(
        colors: [Color(0xFF2E9BFF), Color(0xFF754DFF), Color(0xFF38DFFF)],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, ringPaint);

    // Secondary subtle ring
    final secondaryPaint = Paint()
      ..color = const Color(0xFF5378FF).withValues(alpha: 0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius + 12, secondaryPaint);

    // Rotating light particles
    for (int i = 0; i < 6; i++) {
      final angle = rotation + (i * math.pi / 3);

      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );

      final particlePaint = Paint()
        ..color = i.isEven ? const Color(0xFF49E8FF) : const Color(0xFF9D66FF)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

      canvas.drawCircle(point, 5 + (pulse * 2), particlePaint);

      final corePaint = Paint()..color = Colors.white;

      canvas.drawCircle(point, 1.8, corePaint);
    }
  }

  @override
  bool shouldRepaint(covariant OrbitPainter oldDelegate) {
    return oldDelegate.rotation != rotation || oldDelegate.pulse != pulse;
  }
}

//========================================
// Individual feature card
//========================================

class FeatureNode extends ConsumerStatefulWidget {
  final IconData icon;
  final String title;

  const FeatureNode({super.key, required this.icon, required this.title});

  @override
  ConsumerState<FeatureNode> createState() => _FeatureNodeState();
}

class _FeatureNodeState extends ConsumerState<FeatureNode> {
  bool _isHovered = false;

  // Mouse position relative to the node's center
  Offset _mouseDirection = Offset.zero;

  void _handleHover(PointerEvent event, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final direction = event.localPosition - center;

    final dx = (direction.dx / (size.width / 2)).clamp(-1.0, 1.0);

    final dy = (direction.dy / (size.height / 2)).clamp(-1.0, 1.0);

    setState(() {
      _isHovered = true;
      _mouseDirection = Offset(dx, dy);
    });
  }

  void _handleExit() {
    setState(() {
      _isHovered = false;
      _mouseDirection = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    const movementDistance = 9.0;
    bool isDark = ref.watch(themeIsDarkProvider);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        // The layout size is measured by the outer node.
        final renderBox = context.findRenderObject() as RenderBox;

        _handleHover(event, renderBox.size);
      },
      onExit: (_) => _handleExit(),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,

        transformAlignment: Alignment.center,

        transform: Matrix4.identity()
          ..translate(
            _isHovered ? _mouseDirection.dx * movementDistance : 0.0,
            _isHovered ? _mouseDirection.dy * movementDistance : 0.0,
          )
          ..scale(_isHovered ? 1.10 : 1.0)
          ..rotateX(_isHovered ? -_mouseDirection.dy * 0.10 : 0.0)
          ..rotateY(_isHovered ? _mouseDirection.dx * 0.10 : 0.0),

        width: 125,

        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),

        decoration: BoxDecoration(
          color: _isHovered
              ? isDark
                    ? const Color(0xFF1C2A50)
                    : AppColors.lightCard
              : isDark
              ? const Color(0xFF111832)
              : AppColorsConstant.kPrimaryColor,

          borderRadius: BorderRadius.circular(16),

          border: Border.all(
            color: _isHovered
                ? AppColors.primaryBlue
                : const Color(0xFF536DFF).withValues(alpha: 0.55),

            width: _isHovered ? 1.2 : 1,
          ),

          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFF435CFF,
              ).withValues(alpha: _isHovered ? 0.45 : 0.16),
              blurRadius: _isHovered ? 35 : 20,
              spreadRadius: _isHovered ? 4 : 1,
            ),

            if (_isHovered)
              BoxShadow(
                color: const Color(0xFF58DFFF).withValues(alpha: 0.20),
                blurRadius: 18,
                spreadRadius: 2,
              ),
          ],
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: _isHovered ? 1.2 : 1.0,
              child: Icon(
                widget.icon,
                color: _isHovered
                    ? AppColors.primaryBlue
                    : AppColors.buttonBlueColor,
                size: 23,
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                widget.title,
                maxLines: 2,
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.lightText,
                  fontSize: 11,
                  fontWeight: _isHovered ? FontWeight.w800 : FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
