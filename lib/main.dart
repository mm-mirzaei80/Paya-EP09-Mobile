import 'package:flutter/material.dart';

void main() => runApp(const PayaEp09App());

class PayaEp09App extends StatelessWidget {
  const PayaEp09App({super.key});
  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF3157B7);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EP09 | توسعه فناوری پایا همسان',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero),
        inputDecorationTheme: InputDecorationTheme(
          filled: true, fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget { const LoginPage({super.key}); @override State<LoginPage> createState()=>_LoginPageState(); }
class _LoginPageState extends State<LoginPage> {
  final user = TextEditingController(text:'admin');
  final pass = TextEditingController(text:'admin');
  bool hide=true;
  @override Widget build(BuildContext context){
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(body: SafeArea(child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: ConstrainedBox(constraints: const BoxConstraints(maxWidth:460), child: Column(children:[
      Container(padding:const EdgeInsets.all(20), decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(30),boxShadow:[BoxShadow(color:Colors.black.withValues(alpha:.06),blurRadius:30,offset:const Offset(0,12))]), child:Image.asset('assets/images/logo.png',height:145,fit:BoxFit.contain)),
      const SizedBox(height:26), const Text('سامانه مقایسه روش EP09',style:TextStyle(fontSize:25,fontWeight:FontWeight.w800)), const SizedBox(height:7),
      const Text('توسعه فناوری پایا همسان',style:TextStyle(fontSize:16,fontWeight:FontWeight.w600,color:Color(0xFF3157B7))), const SizedBox(height:30),
      TextField(controller:user,decoration:const InputDecoration(labelText:'نام کاربری',prefixIcon:Icon(Icons.person_outline_rounded))), const SizedBox(height:14),
      TextField(controller:pass,obscureText:hide,decoration:InputDecoration(labelText:'رمز عبور',prefixIcon:const Icon(Icons.lock_outline_rounded),suffixIcon:IconButton(onPressed:()=>setState(()=>hide=!hide),icon:Icon(hide?Icons.visibility_outlined:Icons.visibility_off_outlined)))), const SizedBox(height:20),
      SizedBox(width:double.infinity,height:56,child:FilledButton(onPressed:(){ if(user.text=='admin'&&pass.text=='admin'){Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const HomePage()));} else {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('نام کاربری یا رمز عبور صحیح نیست')));} },style:FilledButton.styleFrom(shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(18))),child:const Text('ورود به سامانه',style:TextStyle(fontSize:17,fontWeight:FontWeight.w700)))),
      const SizedBox(height:14), const Text('نسخه 1.0 • EP09 Method Comparison',style:TextStyle(color:Colors.black45,fontSize:12)),
    ])))))));
  }
}

class HomePage extends StatefulWidget { const HomePage({super.key}); @override State<HomePage> createState()=>_HomePageState(); }
class _HomePageState extends State<HomePage>{ int index=0; final pages=const [DashboardPage(),StudiesPage(),AnalysisPage(),SettingsPage()];
 @override Widget build(BuildContext context)=>Directionality(textDirection:TextDirection.rtl,child:Scaffold(appBar:AppBar(title:Row(children:[Image.asset('assets/images/logo.png',height:38,width:90,fit:BoxFit.contain),const SizedBox(width:8),const Expanded(child:Text('EP09 • پایا همسان',style:TextStyle(fontWeight:FontWeight.w800)))]),actions:[IconButton(onPressed:(){},icon:const Icon(Icons.notifications_none_rounded))]),body:pages[index],bottomNavigationBar:NavigationBar(selectedIndex:index,onDestinationSelected:(v)=>setState(()=>index=v),destinations:const [NavigationDestination(icon:Icon(Icons.dashboard_outlined),selectedIcon:Icon(Icons.dashboard_rounded),label:'داشبورد'),NavigationDestination(icon:Icon(Icons.science_outlined),selectedIcon:Icon(Icons.science_rounded),label:'مطالعات'),NavigationDestination(icon:Icon(Icons.analytics_outlined),selectedIcon:Icon(Icons.analytics_rounded),label:'تحلیل'),NavigationDestination(icon:Icon(Icons.settings_outlined),selectedIcon:Icon(Icons.settings_rounded),label:'تنظیمات')])));
}

class DashboardPage extends StatelessWidget { const DashboardPage({super.key}); @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[
  Container(padding:const EdgeInsets.all(22),decoration:BoxDecoration(borderRadius:BorderRadius.circular(26),gradient:const LinearGradient(colors:[Color(0xFF263B7A),Color(0xFF4267D5)])),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('سلام، مدیر سیستم',style:TextStyle(color:Colors.white70)),SizedBox(height:8),Text('کنترل مطالعات مقایسه روش',style:TextStyle(color:Colors.white,fontSize:23,fontWeight:FontWeight.w800)),SizedBox(height:7),Text('EP09 • 26 Analytes • LC-MS/MS',style:TextStyle(color:Colors.white70))])),
  const SizedBox(height:18), const Text('نمای کلی',style:TextStyle(fontSize:19,fontWeight:FontWeight.w800)),const SizedBox(height:12),
  const Row(children:[Expanded(child:MetricCard(icon:Icons.science_rounded,value:'3',label:'مطالعه فعال')),SizedBox(width:10),Expanded(child:MetricCard(icon:Icons.biotech_rounded,value:'26',label:'آنالیت'))]),const SizedBox(height:10),
  const Row(children:[Expanded(child:MetricCard(icon:Icons.fact_check_outlined,value:'18',label:'تحلیل تکمیل')),SizedBox(width:10),Expanded(child:MetricCard(icon:Icons.warning_amber_rounded,value:'2',label:'نیازمند بررسی'))]),const SizedBox(height:20),
  FilledButton.icon(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const NewStudyPage())),icon:const Icon(Icons.add_rounded),label:const Padding(padding:EdgeInsets.symmetric(vertical:15),child:Text('ایجاد مطالعه جدید EP09'))),
  const SizedBox(height:22),const Text('دسترسی سریع',style:TextStyle(fontSize:19,fontWeight:FontWeight.w800)),const SizedBox(height:10),
  const QuickTile(icon:Icons.upload_file_rounded,title:'ورود داده‌ها',subtitle:'ثبت نتایج روش مرجع و روش مقایسه'),const SizedBox(height:9),const QuickTile(icon:Icons.scatter_plot_rounded,title:'نمودارهای مقایسه',subtitle:'Scatter، Difference و Percent Difference'),const SizedBox(height:9),const QuickTile(icon:Icons.description_outlined,title:'گزارش نهایی',subtitle:'مرور نتایج و خروجی مطالعه'),
 ]); }
class MetricCard extends StatelessWidget {final IconData icon;final String value,label;const MetricCard({super.key,required this.icon,required this.value,required this.label});@override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(22)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(icon,color:Theme.of(context).colorScheme.primary),const SizedBox(height:14),Text(value,style:const TextStyle(fontSize:25,fontWeight:FontWeight.w900)),Text(label,style:const TextStyle(color:Colors.black54))]));}
class QuickTile extends StatelessWidget {final IconData icon;final String title,subtitle;const QuickTile({super.key,required this.icon,required this.title,required this.subtitle});@override Widget build(BuildContext context)=>Container(padding:const EdgeInsets.all(15),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(20)),child:Row(children:[CircleAvatar(backgroundColor:Theme.of(context).colorScheme.primaryContainer,child:Icon(icon)),const SizedBox(width:12),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(title,style:const TextStyle(fontWeight:FontWeight.w800)),Text(subtitle,style:const TextStyle(color:Colors.black54,fontSize:12))])),const Icon(Icons.chevron_left_rounded)]));}

class StudiesPage extends StatelessWidget {const StudiesPage({super.key});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[const Text('مطالعات EP09',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)),const SizedBox(height:14),for(final s in ['مقایسه کیت پایا همسان / روش مرجع','Validation Lot 1405-01','Shimadzu LCMS-8060 Comparison']) Card(child:ListTile(contentPadding:const EdgeInsets.all(16),leading:const CircleAvatar(child:Icon(Icons.science_outlined)),title:Text(s,style:const TextStyle(fontWeight:FontWeight.w700)),subtitle:const Text('26 آنالیت • وضعیت: در حال بررسی'),trailing:const Icon(Icons.chevron_left_rounded))) ]);}
class AnalysisPage extends StatelessWidget {const AnalysisPage({super.key});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[const Text('تحلیل آماری',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)),const SizedBox(height:14),Container(padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(22)),child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text('روش رگرسیون',style:TextStyle(fontWeight:FontWeight.w800)),SizedBox(height:12),Wrap(spacing:8,children:[Chip(label:Text('Deming')),Chip(label:Text('Passing–Bablok'))]),Divider(height:30),Text('خروجی‌های مطالعه',style:TextStyle(fontWeight:FontWeight.w800)),SizedBox(height:8),Text('• Regression & equation\n• Difference plot\n• Percent-difference plot\n• Medical decision points\n• Outlier review')]))]);}
class SettingsPage extends StatelessWidget {const SettingsPage({super.key});@override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[const Text('تنظیمات',style:TextStyle(fontSize:24,fontWeight:FontWeight.w900)),const SizedBox(height:14),const QuickTile(icon:Icons.admin_panel_settings_outlined,title:'مدیریت کاربران',subtitle:'مدیر سیستم و سطوح دسترسی'),const SizedBox(height:9),const QuickTile(icon:Icons.language_rounded,title:'زبان و نمایش',subtitle:'فارسی RTL • English terms'),const SizedBox(height:9),const QuickTile(icon:Icons.info_outline_rounded,title:'درباره نرم‌افزار',subtitle:'توسعه فناوری پایا همسان')]);}
class NewStudyPage extends StatelessWidget {const NewStudyPage({super.key});@override Widget build(BuildContext context)=>Directionality(textDirection:TextDirection.rtl,child:Scaffold(appBar:AppBar(title:const Text('مطالعه جدید EP09')),body:ListView(padding:const EdgeInsets.all(18),children:[const TextField(decoration:InputDecoration(labelText:'عنوان مطالعه')),const SizedBox(height:12),const TextField(decoration:InputDecoration(labelText:'روش مرجع')),const SizedBox(height:12),const TextField(decoration:InputDecoration(labelText:'روش مقایسه')),const SizedBox(height:12),const TextField(decoration:InputDecoration(labelText:'دستگاه / پلتفرم')),const SizedBox(height:18),FilledButton(onPressed:()=>Navigator.pop(context),child:const Padding(padding:EdgeInsets.symmetric(vertical:15),child:Text('ذخیره و ادامه ورود داده‌ها')))])));}
