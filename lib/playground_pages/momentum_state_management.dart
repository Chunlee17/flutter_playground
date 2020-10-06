// import 'package:flutter/material.dart';
// import 'package:flutter_playground/bloc_provider_get_controller/momentum/momentum_counter.dart';
// import 'package:jin_widget_helper/jin_widget_helper.dart';
// import 'package:momentum/momentum.dart';

// class MomentumStateManagementExample extends StatefulWidget {
//   @override
//   _MomentumStateManagementExampleState createState() =>
//       _MomentumStateManagementExampleState();
// }

// class _MomentumStateManagementExampleState
//     extends State<MomentumStateManagementExample> with AfterBuildMixin {
//   @override
//   void initState() {
//     //Momentum.controller<MomentumCounterController>(context).increment();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Momentum Counter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             MomentumBuilder(
//               controllers: [MomentumCounterController],
//               builder: (context, snapshot) {
//                 var counter = snapshot<MomentumCounterModel>();
//                 return Text(
//                   '${counter.value}',
//                   style: Theme.of(context).textTheme.headline4,
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       // we don't need to rebuild the increment button, we can skip the MomentumBuilder
//       floatingActionButton: FloatingActionButton(
//         onPressed:
//             Momentum.controller<MomentumCounterController>(context).increment,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   @override
//   void afterBuild(BuildContext context) {
//     Momentum.controller<MomentumCounterController>(context).increment();
//   }
// }
