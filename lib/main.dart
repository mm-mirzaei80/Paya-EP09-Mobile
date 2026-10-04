import 'package:flutter/material.dart';

void main() {
  runApp(const PayaEp09App());
}

class PayaEp09App extends StatelessWidget {
  const PayaEp09App({super.key});

  static const primary = Color(0xFF3157B7);
  static const background = Color(0xFFF5F7FB);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سامانه مقایسه روش EP09',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: background,
          surfaceTintColor: Colors.transparent,
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: primary,
              width: 1.4,
            ),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class Study {
  final String id;
  String title;
  String instrument;
  String referenceMethod;
  String comparisonMethod;
  String status;
  DateTime createdAt;

  Study({
    required this.id,
    required this.title,
    required this.instrument,
    required this.referenceMethod,
    required this.comparisonMethod,
    required this.status,
    required this.createdAt,
  });
}

final List<Study> appStudies = [
  Study(
    id: 'EP09-001',
    title: 'مقایسه کیت پایا با روش مرجع',
    instrument: 'LC-MS/MS',
    referenceMethod: 'روش مرجع',
    comparisonMethod: 'کیت پایا',
    status: 'در حال بررسی',
    createdAt: DateTime(2026, 9, 20),
  ),
  Study(
    id: 'EP09-002',
    title: 'Validation Lot 1405-01',
    instrument: 'LC-MS/MS',
    referenceMethod: 'روش مرجع',
    comparisonMethod: 'Lot 1405-01',
    status: 'تکمیل شده',
    createdAt: DateTime(2026, 9, 18),
  ),
  Study(
    id: 'EP09-003',
    title: 'Shimadzu LCMS-8060 Comparison',
    instrument: 'Shimadzu LCMS-8060',
    referenceMethod: 'روش مرجع',
    comparisonMethod: 'روش مقایسه',
    status: 'نیازمند بررسی',
    createdAt: DateTime(2026, 9, 15),
  ),
];

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController(text: 'admin');
  final password = TextEditingController(text: 'admin');

  bool obscure = true;
  bool loading = false;

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> login() async {
    FocusScope.of(context).unfocus();

    if (username.text.trim().isEmpty || password.text.isEmpty) {
      _message('نام کاربری و رمز عبور را وارد کنید.');
      return;
    }

    setState(() => loading = true);

    await Future<void>.delayed(
      const Duration(milliseconds: 350),
    );

    if (!mounted) return;

    if (username.text.trim() == 'admin' &&
        password.text == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    } else {
      _message('نام کاربری یا رمز عبور صحیح نیست.');
    }

    if (mounted) {
      setState(() => loading = false);
    }
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 430,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: .07,
                            ),
                            blurRadius: 28,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) {
                            return const Icon(
                              Icons.science_rounded,
                              size: 54,
                              color: PayaEp09App.primary,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'سامانه مقایسه روش EP09',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'مدیریت، تحلیل و گزارش مطالعات روش‌شناسی',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: PayaEp09App.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: username,
                      textDirection: TextDirection.ltr,
                      decoration: const InputDecoration(
                        labelText: 'نام کاربری',
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: password,
                      textDirection: TextDirection.ltr,
                      obscureText: obscure,
                      onSubmitted: (_) => login(),
                      decoration: InputDecoration(
                        labelText: 'رمز عبور',
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: Icon(
                            obscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: FilledButton(
                        onPressed: loading ? null : login,
                        child: loading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'ورود به سامانه',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'نسخه 2.0 • EP09 Method Comparison',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(onRefresh: refresh),
      StudiesPage(onRefresh: refresh),
      const AnalysisPage(),
      const ReportsPage(),
      const SettingsPage(),
    ];

    const titles = [
      'داشبورد',
      'مطالعات',
      'تحلیل',
      'گزارش‌ها',
      'تنظیمات',
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            titles[index],
            style: const TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'اعلان‌ها',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'اعلان جدیدی وجود ندارد.',
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications_none_rounded,
              ),
            ),
            const SizedBox(width: 6),
          ],
        ),
        body: IndexedStack(
          index: index,
          children: pages,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) {
            setState(() {
              index = value;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard_rounded),
              label: 'خانه',
            ),
            NavigationDestination(
              icon: Icon(Icons.science_outlined),
              selectedIcon: Icon(Icons.science_rounded),
              label: 'مطالعات',
            ),
            NavigationDestination(
              icon: Icon(Icons.analytics_outlined),
              selectedIcon: Icon(Icons.analytics_rounded),
              label: 'تحلیل',
            ),
            NavigationDestination(
              icon: Icon(Icons.description_outlined),
              selectedIcon: Icon(Icons.description_rounded),
              label: 'گزارش',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings_rounded),
              label: 'تنظیمات',
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final VoidCallback onRefresh;

  const DashboardPage({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final active = appStudies
        .where((s) => s.status == 'در حال بررسی')
        .length;

    final completed = appStudies
        .where((s) => s.status == 'تکمیل شده')
        .length;

    final review = appStudies
        .where((s) => s.status == 'نیازمند بررسی')
        .length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        18,
        6,
        18,
        24,
      ),
      children: [
        const WelcomeCard(),
        const SizedBox(height: 18),
        const SectionTitle('نمای کلی'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.science_rounded,
                value: '${appStudies.length}',
                label: 'کل مطالعات',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: StatCard(
                icon: Icons.pending_actions_rounded,
                value: '$active',
                label: 'در حال بررسی',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.check_circle_outline_rounded,
                value: '$completed',
                label: 'تکمیل شده',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: StatCard(
                icon: Icons.warning_amber_rounded,
                value: '$review',
                label: 'نیازمند بررسی',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const SectionTitle('عملیات سریع'),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.add_circle_outline_rounded,
          title: 'ایجاد مطالعه جدید',
          subtitle: 'ثبت یک مطالعه جدید EP09',
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NewStudyPage(),
              ),
            );
            onRefresh();
          },
        ),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.upload_file_rounded,
          title: 'ورود داده‌ها',
          subtitle: 'ثبت مقادیر مرجع و مقایسه',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DataEntryPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.insights_rounded,
          title: 'مشاهده تحلیل',
          subtitle: 'مشاهده ابزارهای تحلیل آماری',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AnalysisPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.picture_as_pdf_outlined,
          title: 'گزارش مطالعه',
          subtitle: 'مشاهده خلاصه و خروجی گزارش',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ReportsPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF203A78),
            Color(0xFF4267D5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: PayaEp09App.primary.withValues(
              alpha: .18,
            ),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'سلام، مدیر سیستم 👋',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'مرکز کنترل مطالعات EP09',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'مدیریت • تحلیل • گزارش',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 21,
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .primaryContainer,
              child: Icon(icon),
            ),
            const SizedBox(height: 13),
            Text(
              value,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudiesPage extends StatefulWidget {
  final VoidCallback onRefresh;

  const StudiesPage({
    super.key,
    required this.onRefresh,
  });

  @override
  State<StudiesPage> createState() => _StudiesPageState();
}

class _StudiesPageState extends State<StudiesPage> {
  final search = TextEditingController();

  String filter = 'همه';

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  List<Study> get filtered {
    final q = search.text.trim().toLowerCase();

    return appStudies.where((study) {
      final matchesText = q.isEmpty ||
          study.title.toLowerCase().contains(q) ||
          study.id.toLowerCase().contains(q) ||
          study.instrument.toLowerCase().contains(q);

      final matchesFilter =
          filter == 'همه' || study.status == filter;

      return matchesText && matchesFilter;
    }).toList();
  }

  Future<void> addStudy() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NewStudyPage(),
      ),
    );

    setState(() {});
    widget.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    final items = filtered;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        18,
        6,
        18,
        24,
      ),
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'مطالعات EP09',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            FilledButton.icon(
              onPressed: addStudy,
              icon: const Icon(Icons.add),
              label: const Text('جدید'),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TextField(
          controller: search,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'جستجوی عنوان، کد یا دستگاه...',
            prefixIcon: Icon(Icons.search_rounded),
            suffixIcon: Icon(Icons.tune_rounded),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 42,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _filterChip('همه'),
              _filterChip('در حال بررسی'),
              _filterChip('تکمیل شده'),
              _filterChip('نیازمند بررسی'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        if (items.isEmpty)
          const EmptyState(
            icon: Icons.search_off_rounded,
            title: 'مطالعه‌ای پیدا نشد',
            subtitle: 'عبارت جستجو یا فیلتر را تغییر دهید.',
          ),
        for (final study in items) ...[
          StudyCard(
            study: study,
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StudyDetailsPage(
                    study: study,
                  ),
                ),
              );

              setState(() {});
              widget.onRefresh();
            },
            onDelete: () {
              setState(() {
                appStudies.remove(study);
              });

              widget.onRefresh();
            },
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  Widget _filterChip(String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: ChoiceChip(
        label: Text(value),
        selected: filter == value,
        onSelected: (_) {
          setState(() {
            filter = value;
          });
        },
      ),
    );
  }
}

class StudyCard extends StatelessWidget {
  final Study study;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const StudyCard({
    super.key,
    required this.study,
    required this.onTap,
    required this.onDelete,
  });

  Color statusColor(BuildContext context) {
    switch (study.status) {
      case 'تکمیل شده':
        return Colors.green;
      case 'نیازمند بررسی':
        return Colors.orange;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = statusColor(context);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor:
                    color.withValues(alpha: .12),
                child: Icon(
                  Icons.science_rounded,
                  color: color,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      study.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${study.id} • ${study.instrument}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color:
                            color.withValues(alpha: .10),
                        borderRadius:
                            BorderRadius.circular(30),
                      ),
                      child: Text(
                        study.status,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    onDelete();
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('حذف مطالعه'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StudyDetailsPage extends StatelessWidget {
  final Study study;

  const StudyDetailsPage({
    super.key,
    required this.study,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('جزئیات مطالعه'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Text(
              study.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              study.id,
              style: const TextStyle(
                color: PayaEp09App.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            InfoCard(
              title: 'وضعیت',
              value: study.status,
              icon: Icons.pending_actions_rounded,
            ),
            const SizedBox(height: 10),
            InfoCard(
              title: 'دستگاه / پلتفرم',
              value: study.instrument,
              icon: Icons.biotech_rounded,
            ),
            const SizedBox(height: 10),
            InfoCard(
              title: 'روش مرجع',
              value: study.referenceMethod,
              icon: Icons.science_outlined,
            ),
            const SizedBox(height: 10),
            InfoCard(
              title: 'روش مقایسه',
              value: study.comparisonMethod,
              icon: Icons.compare_arrows_rounded,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DataEntryPage(),
                  ),
                );
              },
              icon: const Icon(Icons.edit_note_rounded),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text('ورود داده‌ها'),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AnalysisPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.analytics_outlined,
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text('تحلیل مطالعه'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewStudyPage extends StatefulWidget {
  const NewStudyPage({super.key});

  @override
  State<NewStudyPage> createState() => _NewStudyPageState();
}

class _NewStudyPageState extends State<NewStudyPage> {
  final title = TextEditingController();
  final instrument = TextEditingController();
  final reference = TextEditingController();
  final comparison = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    instrument.dispose();
    reference.dispose();
    comparison.dispose();
    super.dispose();
  }

  void save() {
    if (title.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'عنوان مطالعه را وارد کنید.',
          ),
        ),
      );
      return;
    }

    final number = appStudies.length + 1;

    appStudies.insert(
      0,
      Study(
        id: 'EP09-${number.toString().padLeft(3, '0')}',
        title: title.text.trim(),
        instrument:
            instrument.text.trim().isEmpty
                ? 'مشخص نشده'
                : instrument.text.trim(),
        referenceMethod:
            reference.text.trim().isEmpty
                ? 'روش مرجع'
                : reference.text.trim(),
        comparisonMethod:
            comparison.text.trim().isEmpty
                ? 'روش مقایسه'
                : comparison.text.trim(),
        status: 'در حال بررسی',
        createdAt: DateTime.now(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'مطالعه با موفقیت ایجاد شد.',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('مطالعه جدید'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'اطلاعات اصلی',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: title,
              decoration: const InputDecoration(
                labelText: 'عنوان مطالعه *',
                prefixIcon: Icon(
                  Icons.title_rounded,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: instrument,
              decoration: const InputDecoration(
                labelText: 'دستگاه / پلتفرم',
                prefixIcon: Icon(
                  Icons.memory_rounded,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: reference,
              decoration: const InputDecoration(
                labelText: 'روش مرجع',
                prefixIcon: Icon(
                  Icons.science_outlined,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: comparison,
              decoration: const InputDecoration(
                labelText: 'روش مقایسه',
                prefixIcon: Icon(
                  Icons.compare_arrows_rounded,
                ),
              ),
            ),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: save,
              icon: const Icon(Icons.save_rounded),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text('ذخیره مطالعه'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataEntryPage extends StatefulWidget {
  const DataEntryPage({super.key});

  @override
  State<DataEntryPage> createState() =>
      _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  final reference = TextEditingController();
  final comparison = TextEditingController();

  double? difference;
  double? percent;

  @override
  void dispose() {
    reference.dispose();
    comparison.dispose();
    super.dispose();
  }

  void calculate() {
    final ref = double.tryParse(
      reference.text.replaceAll(',', '.'),
    );

    final cmp = double.tryParse(
      comparison.text.replaceAll(',', '.'),
    );

    if (ref == null || cmp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'هر دو مقدار عددی را وارد کنید.',
          ),
        ),
      );
      return;
    }

    setState(() {
      difference = cmp - ref;
      percent = ref == 0
          ? null
          : ((cmp - ref) / ref) * 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ورود داده‌ها'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'مقایسه دو مقدار',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'مقادیر مرجع و مقایسه را وارد کنید تا اختلاف محاسبه شود.',
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: reference,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'مقدار روش مرجع',
                prefixIcon: Icon(
                  Icons.science_outlined,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: comparison,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'مقدار روش مقایسه',
                prefixIcon: Icon(
                  Icons.biotech_outlined,
                ),
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: calculate,
              icon: const Icon(
                Icons.calculate_outlined,
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text('محاسبه'),
              ),
            ),
            if (difference != null) ...[
              const SizedBox(height: 20),
              const SectionTitle('نتیجه'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ResultCard(
                      title: 'اختلاف',
                      value:
                          difference!.toStringAsFixed(3),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ResultCard(
                      title: 'اختلاف درصدی',
                      value: percent == null
                          ? '—'
                          : '${percent!.toStringAsFixed(2)}%',
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final String title;
  final String value;

  const ResultCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        18,
        6,
        18,
        24,
      ),
      children: [
        const Text(
          'تحلیل آماری',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'ابزارهای تحلیل مقایسه روش‌ها',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 18),
        AnalysisTile(
          icon: Icons.functions_rounded,
          title: 'رگرسیون Deming',
          subtitle:
              'بررسی شیب، عرض از مبدأ و رابطه دو روش',
          onTap: () {
            _message(
              context,
              'ماژول Deming برای این مطالعه آماده اجراست.',
            );
          },
        ),
        const SizedBox(height: 10),
        AnalysisTile(
          icon: Icons.show_chart_rounded,
          title: 'Passing-Bablok',
          subtitle:
              'تحلیل غیرپارامتریک مقایسه روش‌ها',
          onTap: () {
            _message(
              context,
              'ماژول Passing-Bablok انتخاب شد.',
            );
          },
        ),
        const SizedBox(height: 10),
        AnalysisTile(
          icon: Icons.scatter_plot_rounded,
          title: 'Difference Plot',
          subtitle:
              'بررسی اختلاف بین دو روش',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ChartsPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        AnalysisTile(
          icon: Icons.percent_rounded,
          title: 'Percent Difference',
          subtitle:
              'بررسی اختلاف درصدی نتایج',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DataEntryPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  static void _message(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class AnalysisTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AnalysisTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context)
              .colorScheme
              .primaryContainer,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle),
        ),
        trailing: const Icon(
          Icons.chevron_left_rounded,
        ),
      ),
    );
  }
}

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('نمودارها'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const ChartCard(
              icon: Icons.scatter_plot_rounded,
              title: 'Scatter Plot',
              description:
                  'نمودار پراکندگی روش مرجع و روش مقایسه.',
            ),
            const SizedBox(height: 12),
            const ChartCard(
              icon: Icons.show_chart_rounded,
              title: 'Difference Plot',
              description:
                  'نمایش اختلاف بین دو روش.',
            ),
            const SizedBox(height: 12),
            const ChartCard(
              icon: Icons.percent_rounded,
              title: 'Percent Difference',
              description:
                  'نمایش اختلاف درصدی نتایج.',
            ),
          ],
        ),
      ),
    );
  }
}

class ChartCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const ChartCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor:
                      Theme.of(context)
                          .colorScheme
                          .primaryContainer,
                  child: Icon(icon),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F4FA),
                borderRadius:
                    BorderRadius.circular(18),
              ),
              child: const Center(
                child: Icon(
                  Icons.insights_rounded,
                  size: 52,
                  color: PayaEp09App.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        18,
        6,
        18,
        24,
      ),
      children: [
        const Text(
          'گزارش‌ها',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'خلاصه مطالعات و نتایج تحلیل',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 18),
        for (final study in appStudies) ...[
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(
                  Icons.description_outlined,
                ),
              ),
              title: Text(
                study.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitle: Text(
                '${study.id} • ${study.status}',
              ),
              trailing: const Icon(
                Icons.chevron_left_rounded,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StudyDetailsPage(
                      study: study,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
        FilledButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content: Text(
                  'خروجی PDF در مرحله بعدی اضافه می‌شود.',
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.picture_as_pdf_rounded,
          ),
          label: const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 14,
            ),
            child: Text('تولید گزارش PDF'),
          ),
        ),
      ],
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        18,
        6,
        18,
        24,
      ),
      children: [
        const Text(
          'تنظیمات',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 18),
        ActionTile(
          icon: Icons.admin_panel_settings_outlined,
          title: 'مدیریت کاربران',
          subtitle:
              'مدیریت کاربران و سطح دسترسی',
          onTap: () {
            _message(
              context,
              'مدیریت کاربران در نسخه بعدی تکمیل می‌شود.',
            );
          },
        ),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.language_rounded,
          title: 'زبان و نمایش',
          subtitle: 'فارسی • راست‌چین',
          onTap: () {
            _message(
              context,
              'زبان فعلی: فارسی',
            );
          },
        ),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.info_outline_rounded,
          title: 'درباره برنامه',
          subtitle: 'Paya EP09 Mobile 2.0',
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'Paya EP09 Mobile',
              applicationVersion: '2.0',
              applicationLegalese:
                  'سامانه مدیریت و تحلیل مطالعات EP09',
            );
          },
        ),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.logout_rounded,
          title: 'خروج از حساب',
          subtitle: 'بازگشت به صفحه ورود',
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
              (_) => false,
            );
          },
        ),
      ],
    );
  }

  static void _message(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    Theme.of(context)
                        .colorScheme
                        .primaryContainer,
                child: Icon(icon),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_left_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        leading: Icon(
          icon,
          color:
              Theme.of(context).colorScheme.primary,
        ),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Icon(
              icon,
              size: 52,
              color: Colors.black38,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}