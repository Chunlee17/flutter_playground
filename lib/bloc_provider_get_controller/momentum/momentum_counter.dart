// import 'package:momentum/momentum.dart';

// class MomentumCounterController
//     extends MomentumController<MomentumCounterModel> {
//   @override
//   MomentumCounterModel init() {
//     return MomentumCounterModel(
//       this,
//       value: 0,
//     );
//   }

//   void increment() {
//     var value = model.value;
//     model.update(value: value + 1);
//   }
// }

// class MomentumCounterModel extends MomentumModel<MomentumCounterController> {
//   MomentumCounterModel(
//     MomentumCounterController controller, {
//     this.value,
//   }) : super(controller);

//   final int value;

//   @override
//   void update({int value}) {
//     MomentumCounterModel(
//       controller,
//       value: value ?? this.value,
//     ).updateMomentum();
//   }
// }
