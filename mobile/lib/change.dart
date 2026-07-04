import 'package:flutter/material.dart';

// ── COLORS ──────────────────────────────────────────────────────────────
const Map<String, Color> COLORS = {
  'primary': Color(0xFF1A6B4A),
  'primaryLight': Color(0xFF2E9E6F),
  'primaryPale': Color(0xFFE8F5EF),
  'accent': Color(0xFFF5A623),
  'accentLight': Color(0xFFFEF3DC),
  'dark': Color(0xFF1A1A2E),
  'mid': Color(0xFF4A5568),
  'light': Color(0xFFA0AEC0),
  'bg': Color(0xFFF7F9FB),
  'white': Color(0xFFFFFFFF),
  'danger': Color(0xFFE53E3E),
  'dangerLight': Color(0xFFFFF5F5),
  'border': Color(0xFFE2E8F0),
};

// ── MOCK DATA ────────────────────────────────────────────────────────────
const List<Map<String, dynamic>> MOCK_JOBS = [
  {
    'id': 1,
    'title': "Fix leaking kitchen pipe",
    'category': "Plumbing",
    'budget': "\$80–\$150",
    'location': "Harare, Avondale",
    'urgency': "Today",
    'poster': "Chidi M.",
    'avatar': "CM",
    'avatarColor': "#6B46C1",
    'description': "My kitchen sink pipe has been leaking for 2 days. Need someone experienced ASAP.",
    'posted': "2h ago",
    'applicants': 3,
    'status': "open",
  },
  {
    'id': 2,
    'title': "Full-time house maid needed",
    'category': "Domestic Help",
    'budget': "\$300/month",
    'location': "Bulawayo, Suburbs",
    'urgency': "This week",
    'poster': "Amara T.",
    'avatar': "AT",
    'avatarColor': "#D69E2E",
    'description': "Looking for a trustworthy, experienced maid for a family of 4. Cooking included.",
    'posted': "5h ago",
    'applicants': 7,
    'status': "open",
  },
  {
    'id': 3,
    'title': "Electrical rewiring – 3 rooms",
    'category': "Electrician",
    'budget': "\$200–\$350",
    'location': "Harare, Borrowdale",
    'urgency': "Flexible",
    'poster': "James O.",
    'avatar': "JO",
    'avatarColor': "#2B6CB0",
    'description': "Need a certified electrician to rewire 3 bedrooms. Must show valid certification.",
    'posted': "1d ago",
    'applicants': 2,
    'status': "open",
  },
  {
    'id': 4,
    'title': "Garden landscaping & lawn care",
    'category': "Gardening",
    'budget': "\$50–\$100",
    'location': "Harare, Highlands",
    'urgency': "Weekend",
    'poster': "Fatima K.",
    'avatar': "FK",
    'avatarColor': "#276749",
    'description': "Want my garden cleaned up and shaped before a family event this weekend.",
    'posted': "3h ago",
    'applicants': 5,
    'status': "open",
  },
];

const List<Map<String, String>> CATEGORIES = [
  {'icon': '🔧', 'label': 'Plumbing'},
  {'icon': '⚡', 'label': 'Electrician'},
  {'icon': '🏠', 'label': 'Domestic Help'},
  {'icon': '🌿', 'label': 'Gardening'},
  {'icon': '🚗', 'label': 'Auto Repair'},
  {'icon': '🎨', 'label': 'Painting'},
  {'icon': '🔐', 'label': 'Security'},
  {'icon': '📦', 'label': 'Moving'},
];

// ── SMALL COMPONENTS ─────────────────────────────────────────────────────
class Avatar extends StatelessWidget {
  final String initials;
  final Color color;
  final double size;

  const Avatar({
    required this.initials,
    required this.color,
    this.size = 38,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.35,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final String label;
  final Color color;
  final Color? bg;

  const Badge({
    required this.label,
    this.color = COLORS.primary,
    this.bg,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg ?? color.withOpacity(0.09),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

enum ButtonVariant { primary, secondary, accent, ghost, danger }

class Btn extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final String size;
  final EdgeInsets? customPadding;

  const Btn({
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = "md",
    this.customPadding,
    Key? key,
  }) : super(key: key);

  @override
  State<Btn> createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (widget.variant) {
      case ButtonVariant.primary:
        bgColor = COLORS.primary;
        textColor = Colors.white;
        break;
      case ButtonVariant.secondary:
        bgColor = COLORS.primaryPale;
        textColor = COLORS.primary;
        break;
      case ButtonVariant.accent:
        bgColor = COLORS.accent;
        textColor = Colors.white;
        break;
      case ButtonVariant.ghost:
        bgColor = Colors.transparent;
        textColor = COLORS.primary;
        break;
      case ButtonVariant.danger:
        bgColor = COLORS.danger;
        textColor = Colors.white;
        break;
    }

    double fontSize = widget.size == "sm" ? 13 : 15;
    EdgeInsets padding = widget.customPadding ??
        (widget.size == "sm"
            ? const EdgeInsets.symmetric(horizontal: 14, vertical: 8)
            : const EdgeInsets.symmetric(horizontal: 20, vertical: 14));

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: widget.variant == ButtonVariant.ghost
              ? Border.all(color: COLORS.primary, width: 1.5)
              : null,
        ),
        opacity: _isPressed ? 0.8 : 1,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            child: Padding(
              padding: padding,
              child: Text(
                widget.text,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  final String? label;
  final String placeholder;
  final TextEditingController controller;
  final String icon;
  final bool obscure;

  const Input({
    this.label,
    required this.placeholder,
    required this.controller,
    this.icon = '',
    this.obscure = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                label!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: COLORS.mid,
                ),
              ),
            ),
          TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: placeholder,
              prefixText: icon.isNotEmpty ? '  ' : null,
              prefixIcon: icon.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: Text(icon),
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              filled: true,
              fillColor: COLORS.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: COLORS.border, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: COLORS.border, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: COLORS.primary, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const Card({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.only(bottom: 12),
    this.backgroundColor = COLORS.white,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

// ── SCREENS ──────────────────────────────────────────────────────────────

// SPLASH / ONBOARDING
class SplashScreen extends StatelessWidget {
  final Function(String) onNext;

  const SplashScreen({required this.onNext, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [COLORS.primary, COLORS.primaryLight, Color(0xFF1a9e6b)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🔗', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 16),
            const Text(
              'TaskLink',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Post a job. Find the right person.\nGet things done.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(191, 255, 255, 255),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Btn(
                      text: 'Sign In',
                      onPressed: () => onNext('login'),
                      variant: ButtonVariant.accent,
                      customPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Btn(
                      text: 'Create Account',
                      onPressed: () => onNext('register'),
                      variant: ButtonVariant.ghost,
                      customPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Plumbers · Electricians · Maids · Gardeners & more',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(128, 255, 255, 255),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// LOGIN
class LoginScreen extends StatefulWidget {
  final Function(String) onLogin;
  final VoidCallback onBack;

  const LoginScreen({required this.onLogin, required this.onBack, Key? key})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            GestureDetector(
              onTap: widget.onBack,
              child: const Text('←', style: TextStyle(fontSize: 22, color: COLORS.dark)),
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome back',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: COLORS.dark),
            ),
            const SizedBox(height: 4),
            const Text(
              'Sign in to your TaskLink account',
              style: TextStyle(fontSize: 14, color: COLORS.light),
            ),
            const SizedBox(height: 32),
            Input(
              label: 'Email',
              placeholder: 'you@email.com',
              controller: emailController,
              icon: '📧',
            ),
            Input(
              label: 'Password',
              placeholder: '••••••••',
              controller: passwordController,
              icon: '🔒',
              obscure: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: COLORS.primary),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Btn(
                text: 'Sign In as Client',
                onPressed: () => widget.onLogin('client'),
                customPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Btn(
                text: 'Sign In as Worker',
                onPressed: () => widget.onLogin('worker'),
                variant: ButtonVariant.secondary,
                customPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// REGISTER
class RegisterScreen extends StatefulWidget {
  final Function(String) onRegister;
  final VoidCallback onBack;

  const RegisterScreen({required this.onRegister, required this.onBack, Key? key})
      : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String? selectedRole;
  bool certUploaded = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.bg,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            GestureDetector(
              onTap: widget.onBack,
              child: const Text('←', style: TextStyle(fontSize: 22, color: COLORS.dark)),
            ),
            const SizedBox(height: 16),
            const Text(
              'Create Account',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: COLORS.dark),
            ),
            const SizedBox(height: 4),
            const Text(
              'Join TaskLink today',
              style: TextStyle(fontSize: 14, color: COLORS.light),
            ),
            const SizedBox(height: 24),
            const Text(
              'I am a…',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: COLORS.mid),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedRole = 'client'),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedRole == 'client' ? COLORS.primary : COLORS.border,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        color: selectedRole == 'client' ? COLORS.primaryPale : COLORS.white,
                      ),
                      child: Column(
                        children: [
                          const Text('📋', style: TextStyle(fontSize: 28)),
                          const SizedBox(height: 4),
                          Text(
                            'Client\n(Post Jobs)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selectedRole == 'client' ? COLORS.primary : COLORS.mid,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selectedRole = 'worker'),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedRole == 'worker' ? COLORS.primary : COLORS.border,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        color: selectedRole == 'worker' ? COLORS.primaryPale : COLORS.white,
                      ),
                      child: Column(
                        children: [
                          const Text('🛠️', style: TextStyle(fontSize: 28)),
                          const SizedBox(height: 4),
                          Text(
                            'Worker\n(Find Jobs)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selectedRole == 'worker' ? COLORS.primary : COLORS.mid,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Input(
              label: 'Full Name',
              placeholder: 'Your name',
              controller: nameController,
              icon: '👤',
            ),
            Input(
              label: 'Email',
              placeholder: 'you@email.com',
              controller: emailController,
              icon: '📧',
            ),
            Input(
              label: 'Password',
              placeholder: '••••••••',
              controller: passwordController,
              icon: '🔒',
              obscure: true,
            ),
            if (selectedRole == 'worker')
              Card(
                backgroundColor: COLORS.accentLight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📄 Upload Certification',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: COLORS.dark),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Clients trust verified workers more. Upload your trade certificate.',
                      style: TextStyle(fontSize: 12, color: COLORS.mid),
                    ),
                    const SizedBox(height: 10),
                    if (!certUploaded)
                      Btn(
                        text: 'Choose File',
                        onPressed: () => setState(() => certUploaded = true),
                        variant: ButtonVariant.accent,
                        size: 'sm',
                      )
                    else
                      const Text(
                        '✅ certificate_plumbing.pdf uploaded',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: COLORS.primary),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Btn(
                text: 'Create Account',
                onPressed: selectedRole != null ? () => widget.onRegister(selectedRole!) : () {},
                customPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// HOME FEED (CLIENT)
class ClientHome extends StatefulWidget {
  final Function(String) onNav;
  final Function(Map<String, dynamic>) onJobPress;

  const ClientHome({required this.onNav, required this.onJobPress, Key? key}) : super(key: key);

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  late TextEditingController searchController;
  String? activeCategory;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filtered {
    return MOCK_JOBS.where((j) {
      bool categoryMatch = activeCategory == null || j['category'] == activeCategory;
      bool searchMatch = searchController.text.isEmpty ||
          (j['title'] as String).toLowerCase().contains(searchController.text.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  Color _getColor(String hex) {
    return Color(int.parse(hex.replaceFirst('#', '0xff')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLORS.bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: COLORS.primary,
            expandedHeight: 200,
            pinned: true,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Good morning,', style: TextStyle(color: Color.fromARGB(179, 255, 255, 255), fontSize: 13)),
                            Text('Chidi 👋', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                          ],
                        ),
                        Avatar(initials: 'CM', color: Color(0xFF6B46C1), size: 42),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: searchController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: 'Search for a service…',
                        prefixIcon: const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('🔍')),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    backgroundColor: COLORS.primary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Need something done?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                              SizedBox(height: 2),
                              Text('Post a task and get offers', style: TextStyle(fontSize: 12, color: Color.fromARGB(191, 255, 255, 255))),
                            ],
                          ),
                        ),
                        Btn(text: 'Post Task', onPressed: () => widget.onNav('post'), variant: ButtonVariant.accent, size: 'sm'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Browse by Category', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: COLORS.dark)),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: CATEGORIES.map((c) {
                        bool selected = activeCategory == c['label'];
                        return GestureDetector(
                          onTap: () => setState(() => activeCategory = selected ? null : c['label']),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: selected ? COLORS.primary : COLORS.border, width: 1.5),
                              borderRadius: BorderRadius.circular(14),
                              color: selected ? COLORS.primaryPale : COLORS.white,
                            ),
                            child: Column(children: [
                              Text(c['icon']!, style: const TextStyle(fontSize: 20)),
                              const SizedBox(height: 4),
                              Text(c['label']!, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: selected ? COLORS.primary : COLORS.mid)),
                            ]),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    activeCategory != null ? '$activeCategory Jobs' : 'Recent Tasks',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: COLORS.dark),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final job = filtered[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    onTap: () => widget.onJobPress(job),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(job['title'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: COLORS.dark)),
                                  const SizedBox(height: 2),
                                  Text('📍 ${job['location']}', style: const TextStyle(fontSize: 12, color: COLORS.light)),
                                ],
                              ),
                            ),
                            Badge(label: job['urgency'], color: job['urgency'] == "Today" ? COLORS.danger : COLORS.primary),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          job['description'].length > 80 ? '${job['description'].substring(0, 80)}…' : job['description'],
                          style: const TextStyle(fontSize: 13, color: COLORS.mid, height: 1.5),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Avatar(initials: job['avatar'], color: _getColor(job['avatarColor']), size: 26),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(job['poster'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: COLORS.mid)),
                                    Text('· ${job['posted']}', style: const TextStyle(fontSize: 11, color: COLORS.light)),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Badge(label: job['category']),
                                const SizedBox(width: 8),
                                Text(job['budget'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: COLORS.primary)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: filtered.length,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}

// MAIN APP
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String screen = 'splash';
  String? userRole;
  Map<String, dynamic>? selectedJob;

  @override
  Widget build(BuildContext context) {
    if (screen == 'splash') {
      return MaterialApp(
        home: SplashScreen(onNext: (s) => setState(() => screen = s)),
        debugShowCheckedModeBanner: false,
      );
    }
    if (screen == 'login') {
      return MaterialApp(
        home: LoginScreen(
          onLogin: (role) => setState(() { userRole = role; screen = 'main'; }),
          onBack: () => setState(() => screen = 'splash'),
        ),
        debugShowCheckedModeBanner: false,
      );
    }
    if (screen == 'register') {
      return MaterialApp(
        home: RegisterScreen(
          onRegister: (role) => setState(() { userRole = role; screen = 'main'; }),
          onBack: () => setState(() => screen = 'splash'),
        ),
        debugShowCheckedModeBanner: false,
      );
    }
    if (selectedJob != null) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: COLORS.primary,
            title: Text(selectedJob!['title']),
            leading: GestureDetector(
              onTap: () => setState(() => selectedJob = null),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Avatar(
                            initials: selectedJob!['avatar'],
                            color: Color(int.parse(selectedJob!['avatarColor'].replaceFirst('#', '0xff'))),
                            size: 44,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(selectedJob!['poster'], style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: COLORS.dark)),
                                Text('${selectedJob!['posted']} · ${selectedJob!['location']}', style: const TextStyle(fontSize: 12, color: COLORS.light)),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Badge(label: selectedJob!['category']),
                                    const SizedBox(width: 6),
                                    Badge(
                                      label: selectedJob!['urgency'],
                                      color: selectedJob!['urgency'] == "Today" ? COLORS.danger : COLORS.primary,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(selectedJob!['description'], style: const TextStyle(fontSize: 14, color: COLORS.mid, height: 1.7)),
                    ],
                  ),
                ),
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(children: [
                        Text(selectedJob!['budget'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: COLORS.primary)),
                        const Text('Budget', style: TextStyle(fontSize: 12, color: COLORS.light)),
                      ]),
                      Column(children: [
                        Text('${selectedJob!['applicants']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: COLORS.primary)),
                        const Text('Applicants', style: TextStyle(fontSize: 12, color: COLORS.light)),
                      ]),
                      Column(children: [
                        const Text('Open', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF27AE60))),
                        const Text('Status', style: TextStyle(fontSize: 12, color: COLORS.light)),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Btn(
                    text: '💬 Message ${selectedJob!['poster']}',
                    onPressed: () {},
                    variant: ButtonVariant.ghost,
                  ),
                ),
              ],
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
      );
    }
    return MaterialApp(
      home: ClientHome(
        onNav: (nav) => setState(() => screen = nav),
        onJobPress: (job) => setState(() => selectedJob = job),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
