# Dart Exercises - Week 11: Asynchronous Programming

**Name:** Jeslyn Kyl Sesma
**Section:** 3.3 BSIT
**Course:** NTC_PC16 - Mobile Development w/ Lab
**Activity:** Week 11 Your Turn - Add Async Behavior to Your OOP App

---

## Description
This console-based Dart program builds on the Week 10 `Student` class hierarchy. It adds an asynchronous method, `saveRecord()`, which simulates saving a student's record to a server with a 2-second delay. The program shows that waiting for the result does not freeze the rest of the program.

## Files
| File | Description |
|---|---|
| `week11_student_async.dart` | Source code with the Week 10 hierarchy and the new async method |
| `output.txt` | Sample program output |

## What Was Added in Week 11
| Concept | Where it is used |
|---|---|
| **Future** | `Future<String> saveRecord()` in the `Student` class returns a `String` that is ready later. |
| **async** | `saveRecord()` and `main()` are marked `async`, so they can use `await`. |
| **Future.delayed** | `await Future.delayed(const Duration(seconds: 2))` simulates the time a server save takes. |
| **await** | `main()` calls `await pending` and `await s2.saveRecord()`, and prints the result only after it is ready. |
| **Non-blocking proof** | "Main continues: doing other work while saving..." prints before the saved record message appears. |

Because `saveRecord()` is in the abstract `Student` class, both `UndergraduateStudent` and `GraduateStudent` inherit it.

## Sample Output (Async Section)
```
Starting save for Jeslyn Kyl Sesma...
Saving record for Jeslyn Kyl Sesma...
Main continues: doing other work while saving...
Record for Jeslyn Kyl Sesma (2026-0001) saved. Average: 89.50
Saving record for Juan Dela Cruz...
Record for Juan Dela Cruz (2026-0002) saved. Average: 82.00
All records saved.
```
The saved-record lines appear after a 2-second pause each. The whole output sample can be viewed at `output.txt`.

## Testing
The program was run more than once. The order of the messages and the 2-second delay were the same each time.

## Earlier OOP Concepts (Weeks 9-10)
Classes, constructors, encapsulation, Lists and Maps, inheritance, polymorphism, an abstract class (`Student`) and a mixin (`Loggable`) are carried over from Weeks 9 and 10.

## How to Run
1. Open [DartPad](https://dartpad.dev).
2. Copy the contents of `week11_student_async.dart` into the editor.
3. Click **Run**.

Or, with the Dart SDK installed:
```bash
dart run week11_student_async.dart
```
