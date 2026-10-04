
import 'package:flutter/material.dart';

void main() {
  runApp(const PayaEp09App());
}

class PayaEp09App extends StatelessWidget {
  const PayaEp09App({super.key});

  static const seed = Color(0xFF3157B7);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سامانه مقایسه روش EP09',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// -----------------------------------------------------------------------------
// LOGIN
// -----------------------------------------------------------------------------

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController(text: 'admin');
  final passController = TextEditingController(text: 'admin');

  bool hidePassword = true;

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  void login() {
    if (userController.text.trim() == 'admin' &&
        passController.text == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('نام کاربری یا رمز عبور صحیح نیست'),
        ),
      );
    }
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
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .06),
                            blurRadius: 30,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 145,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'سامانه مقایسه روش EP09',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'توسعه فناوری پایا همسان',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3157B7),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: userController,
                      decoration: const InputDecoration(
                        labelText: 'نام کاربری',
                        prefixIcon: Icon(Icons.person_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: passController,
                      obscureText: hidePassword,
                      onSubmitted: (_) => login(),
                      decoration: InputDecoration(
                        labelText: 'رمز عبور',
                        prefixIcon:
                            const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: login,
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Text(
                          'ورود به سامانه',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'نسخه 1.0 • EP09 Method Comparison',
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

// -----------------------------------------------------------------------------
// HOME
// -----------------------------------------------------------------------------

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final pages = const [
    DashboardPage(),
    StudiesPage(),
    AnalysisPage(),
    SettingsPage(),
  ];

  final titles = const [
    'داشبورد',
    'مطالعات EP09',
    'تحلیل آماری',
    'تنظیمات',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 38,
                width: 90,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  titles[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'اعلان‌ها',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('در حال حاضر اعلان جدیدی وجود ندارد'),
                  ),
                );
              },
              icon: const Icon(Icons.notifications_none_rounded),
            ),
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
              label: 'داشبورد',
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

// -----------------------------------------------------------------------------
// DASHBOARD
// -----------------------------------------------------------------------------

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF263B7A),
                Color(0xFF4267D5),
              ],
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'سلام، مدیر سیستم',
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(height: 8),
              Text(
                'کنترل مطالعات مقایسه روش',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 7),
              Text(
                'EP09 • 26 Analytes • LC-MS/MS',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'نمای کلی',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: MetricCard(
                icon: Icons.science_rounded,
                value: '3',
                label: 'مطالعه فعال',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: MetricCard(
                icon: Icons.biotech_rounded,
                value: '26',
                label: 'آنالیت',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(
              child: MetricCard(
                icon: Icons.fact_check_outlined,
                value: '18',
                label: 'تحلیل تکمیل',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: MetricCard(
                icon: Icons.warning_amber_rounded,
                value: '2',
                label: 'نیازمند بررسی',
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NewStudyPage(),
              ),
            );
          },
          icon: const Icon(Icons.add_rounded),
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text('ایجاد مطالعه جدید EP09'),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'دسترسی سریع',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        QuickTile(
          icon: Icons.upload_file_rounded,
          title: 'ورود داده‌ها',
          subtitle: 'ثبت نتایج روش مرجع و روش مقایسه',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const DataEntryPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 9),
        QuickTile(
          icon: Icons.scatter_plot_rounded,
          title: 'نمودارهای مقایسه',
          subtitle: 'Scatter، Difference و Percent Difference',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ChartsPage(),
              ),
            );
          },
        ),
        const SizedBox(height: 9),
        QuickTile(
          icon: Icons.description_outlined,
          title: 'گزارش نهایی',
          subtitle: 'مرور نتایج و خروجی مطالعه',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ReportPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const MetricCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label: $value')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 14),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// STUDIES
// -----------------------------------------------------------------------------

class StudiesPage extends StatelessWidget {
  const StudiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final studies = [
      'مقایسه کیت پایا همسان / روش مرجع',
      'Validation Lot 1405-01',
      'Shimadzu LCMS-8060 Comparison',
    ];

    return ListView(
      padding: const EdgeInsets.all(18),
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NewStudyPage(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('جدید'),
            ),
          ],
        ),
        const SizedBox(height: 14),
        for (final study in studies) ...[
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(
                child: Icon(Icons.science_outlined),
              ),
              title: Text(
                study,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: const Text(
                '26 آنالیت • وضعیت: در حال بررسی',
              ),
              trailing: const Icon(Icons.chevron_left_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StudyDetailsPage(title: study),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// STUDY DETAILS
// -----------------------------------------------------------------------------

class StudyDetailsPage extends StatelessWidget {
  final String title;

  const StudyDetailsPage({
    super.key,
    required this.title,
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
              title,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20),
            const InfoCard(
              title: 'وضعیت',
              value: 'در حال بررسی',
              icon: Icons.pending_actions,
            ),
            const SizedBox(height: 10),
            const InfoCard(
              title: 'تعداد آنالیت',
              value: '26',
              icon: Icons.biotech,
            ),
            const SizedBox(height: 10),
            const InfoCard(
              title: 'روش آماری',
              value: 'Deming / Passing-Bablok',
              icon: Icons.analytics,
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
              icon: const Icon(Icons.edit_note),
              label: const Text('ورود داده‌ها'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChartsPage(),
                  ),
                );
              },
              icon: const Icon(Icons.show_chart),
              label: const Text('مشاهده نمودارها'),
            ),
          ],
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
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// ANALYSIS
// -----------------------------------------------------------------------------

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'تحلیل آماری',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 14),
        AnalysisAction(
          icon: Icons.functions,
          title: 'رگرسیون Deming',
          subtitle: 'محاسبه شیب، عرض از مبدأ و همبستگی',
          onTap: () {
            showAnalysisMessage(context, 'رگرسیون Deming انتخاب شد');
          },
        ),
        const SizedBox(height: 10),
        AnalysisAction(
          icon: Icons.show_chart,
          title: 'Passing-Bablok',
          subtitle: 'تحلیل غیرپارامتریک مقایسه روش',
          onTap: () {
            showAnalysisMessage(context, 'Passing-Bablok انتخاب شد');
          },
        ),
        const SizedBox(height: 10),
        AnalysisAction(
          icon: Icons.scatter_plot,
          title: 'Difference Plot',
          subtitle: 'بررسی اختلاف روش‌ها',
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
        AnalysisAction(
          icon: Icons.picture_as_pdf,
          title: 'گزارش تحلیل',
          subtitle: 'مشاهده خلاصه خروجی مطالعه',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ReportPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  void showAnalysisMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class AnalysisAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AnalysisAction({
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
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_left),
        onTap: onTap,
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SETTINGS
// -----------------------------------------------------------------------------

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'تنظیمات',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 14),
        QuickTile(
          icon: Icons.admin_panel_settings_outlined,
          title: 'مدیریت کاربران',
          subtitle: 'مدیریت سیستم و سطوح دسترسی',
          onTap: () {
            showMessage(context, 'بخش مدیریت کاربران');
          },
        ),
        const SizedBox(height: 9),
        QuickTile(
          icon: Icons.language_rounded,
          title: 'زبان و نمایش',
          subtitle: 'فارسی RTL • English terms',
          onTap: () {
            showMessage(context, 'زبان فعلی: فارسی');
          },
        ),
        const SizedBox(height: 9),
        QuickTile(
          icon: Icons.info_outline_rounded,
          title: 'درباره نرم‌افزار',
          subtitle: 'توسعه فناوری پایا همسان',
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'EP09 Method Comparison',
              applicationVersion: '1.0',
              applicationLegalese: 'توسعه فناوری پایا همسان',
            );
          },
        ),
        const SizedBox(height: 9),
        QuickTile(
          icon: Icons.logout_rounded,
          title: 'خروج از حساب',
          subtitle: 'بازگشت به صفحه ورود',
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const LoginPage(),
              ),
              (route) => false,
            );
          },
        ),
      ],
    );
  }

  void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

// -----------------------------------------------------------------------------
// NEW STUDY
// -----------------------------------------------------------------------------

class NewStudyPage extends StatefulWidget {
  const NewStudyPage({super.key});

  @override
  State<NewStudyPage> createState() => _NewStudyPageState();
}

class _NewStudyPageState extends State<NewStudyPage> {
  final titleController = TextEditingController();
  final referenceController = TextEditingController();
  final comparisonController = TextEditingController();
  final instrumentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    referenceController.dispose();
    comparisonController.dispose();
    instrumentController.dispose();
    super.dispose();
  }

  void save() {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('عنوان مطالعه را وارد کنید'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('مطالعه با موفقیت ثبت شد'),
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
          title: const Text('مطالعه جدید EP09'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'عنوان مطالعه',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: referenceController,
              decoration: const InputDecoration(
                labelText: 'روش مرجع',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: comparisonController,
              decoration: const InputDecoration(
                labelText: 'روش مقایسه',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: instrumentController,
              decoration: const InputDecoration(
                labelText: 'دستگاه / پلتفرم',
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: save,
              icon: const Icon(Icons.save),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('ذخیره و ادامه'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// DATA ENTRY
// -----------------------------------------------------------------------------

class DataEntryPage extends StatefulWidget {
  const DataEntryPage({super.key});

  @override
  State<DataEntryPage> createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  final reference = TextEditingController();
  final comparison = TextEditingController();

  @override
  void dispose() {
    reference.dispose();
    comparison.dispose();
    super.dispose();
  }

  void saveData() {
    if (reference.text.trim().isEmpty ||
        comparison.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('هر دو مقدار را وارد کنید'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('داده با موفقیت ثبت شد'),
      ),
    );
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
              'نمونه داده',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: reference,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'مقدار روش مرجع',
                prefixIcon: Icon(Icons.science),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: comparison,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'مقدار روش مقایسه',
                prefixIcon: Icon(Icons.biotech),
              ),
            ),
            const SizedBox(height: 18),
            FilledButton.icon(
              onPressed: saveData,
              icon: const Icon(Icons.save),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('ثبت داده'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CHARTS
// -----------------------------------------------------------------------------

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('نمودارهای مقایسه'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            ChartPlaceholder(
              icon: Icons.scatter_plot,
              title: 'Scatter Plot',
              subtitle: 'نمودار پراکندگی روش مرجع و روش مقایسه',
            ),
            const SizedBox(height: 12),
            ChartPlaceholder(
              icon: Icons.show_chart,
              title: 'Difference Plot',
              subtitle: 'بررسی اختلاف بین دو روش',
            ),
            const SizedBox(height: 12),
            ChartPlaceholder(
              icon: Icons.bar_chart,
              title: 'Percent Difference',
              subtitle: 'بررسی اختلاف درصدی',
            ),
          ],
        ),
      ),
    );
  }
}

class ChartPlaceholder extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ChartPlaceholder({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              icon,
              size: 55,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F4FA),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: Text(
                  'نمودار پس از ورود داده‌ها نمایش داده می‌شود',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// REPORT
// -----------------------------------------------------------------------------

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('گزارش نهایی'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'گزارش مطالعه EP09',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 18),
            const InfoCard(
              title: 'وضعیت مطالعه',
              value: 'در حال بررسی',
              icon: Icons.pending_actions,
            ),
            const SizedBox(height: 10),
            const InfoCard(
              title: 'تعداد آنالیت',
              value: '26',
              icon: Icons.biotech,
            ),
            const SizedBox(height: 10),
            const InfoCard(
              title: 'روش آماری',
              value: 'Deming / Passing-Bablok',
              icon: Icons.analytics,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'گزارش آماده تولید است',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text('تولید گزارش'),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// QUICK TILE
// -----------------------------------------------------------------------------

class QuickTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const QuickTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                child: Icon(icon),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
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
              const Icon(Icons.chevron_left_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

