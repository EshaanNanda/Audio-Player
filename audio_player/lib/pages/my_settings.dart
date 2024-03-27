// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:audio_player/theme/theme_provider.dart';
// import 'package:provider/provider.dart';
//
// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});
//
//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }
//
// class _SettingsPageState extends State<SettingsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         title: Padding(
//           padding: const EdgeInsets.only(left: 70),
//           child: Text("S E T T I N G S"),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.background,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         margin: EdgeInsets.all(25),
//         decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.primary,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "Dark Mode",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             CupertinoSwitch(
//                 value: Provider.of<ThemeProvider>(context, listen: false)
//                     .isDarkMode,
//                 onChanged: (value) =>
//                     Provider.of<ThemeProvider>(context, listen: false)
//                         .toggleTheme())
//           ],
//         ),
//       ),
//     );
//   }
// }
