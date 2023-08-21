
import 'package:flutter/material.dart';

class ScheduleByDay extends StatefulWidget {
  const ScheduleByDay({super.key});

  @override
  State<ScheduleByDay> createState() => _ScheduleByDayState();
}

class _ScheduleByDayState extends State<ScheduleByDay> {

    int _currentStep  =0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stepper(
        
        currentStep: _currentStep,
          onStepTapped: (int step) => setState(() => _currentStep = step),
          onStepContinue:
              _currentStep < 2 ? () => setState(() => _currentStep += 1) : null,
          onStepCancel:
              _currentStep > 0 ? () => setState(() => _currentStep -= 1) : null,
          steps: const [
            Step(
              title: Text('Step 1'),
              content: Text('This is the first step.'),
            ),
            Step(
              title: Text('Step 2'),
              content: Text('This is the second step.'),
            ),
            Step(
              title: Text('Step 3'),
              content: Text('This is the third and final step.'),
            ),]),
    );
  }
}