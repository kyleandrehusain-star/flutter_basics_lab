# IT 120 — Flutter Architecture, Widgets and Basic UI

**Name:** Husain, Kyle Andre S.
**Section:** ALL
**Student ID:** 241-000569
**Lab:** 1 — Flutter Architecture, Widgets and Basic UI (Activities 1–5)
**Date:** 19 October 2026

---

## 1. GitHub repository link

**https://github.com/kyleandrehusain-star/flutter_basics_lab**

The repository was created with the `flutter_basics_lab` name, and the code
was pushed from the project folder with:

```sh
git init
git add .
git commit -m "Lab: Flutter widgets, layouts and UI components"
git branch -M main
git remote add origin https://github.com/kyleandrehusain-star/flutter_basics_lab.git
git push -u origin main
```

The `build/` folder is excluded by the `.gitignore` that Flutter created, so
only the source code, `pubspec.yaml`, the `screenshots/` folder and this
answers file are in the repository.

---

## 2. Last three `build() called` lines from Activity 2

From the Debug Console (Ctrl+Shift+Y) after tapping **+** until the goal of 6
glasses was reached:

```
build() called: 4 glasses
build() called: 5 glasses
build() called: 6 glasses
```

A new line appears every time the screen is redrawn, because `build()` is the
method that draws the screen from the current value of `_glasses`.

---

## 3. Observations from the experiments

### Activity 2 — moving `_glasses++` outside of `setState()`

When I moved the counter update out of `setState()` and tapped **+**, the
number on the screen did not change at all. The drink icon stayed the same
colour and the message did not switch either. The reason is that `setState()`
is what tells Flutter "my data changed, please redraw". Without it, `_glasses`
really did increase in memory, but Flutter had no reason to call `build()`
again, so the old number stayed on the screen. The interesting part was what
happened later: as soon as *something else* did call `setState()` (for example
tapping **Reset** or **−**), the screen suddenly jumped and showed the values
that had been "hidden" all along. That is why the change has to be inside
`setState()`.

### Activity 3 — removing `Expanded` from one `StatBox`

When I removed `Expanded` from the *Feels like* box, that box stopped sharing
the row's width equally with the other two. `Expanded` tells a child to take
all the space that is left over, so with all three boxes wrapped in it, the
row divided the width into three equal parts no matter how long the labels
were. Without it, the box fell back to its own natural size and was sized by
its content instead, so the three boxes were no longer the same width and the
row looked unbalanced. The two boxes that still had `Expanded` simply split
what was left over between them. `Expanded` is what keeps a `Row` of cards
aligned and prevents the text from overflowing on a narrow window.

### Activity 5 — changing the button corner radius in `buildTheme()`

I changed `BorderRadius.circular(8)` to `BorderRadius.circular(20)` in the
`elevatedButtonTheme` of `buildTheme()`. The change was instant and it
affected the **Elevated** button only — the Outlined and Filled buttons kept
their own shapes, because they are styled by their own widget types, not by
`elevatedButtonTheme`. The Elevated button now looked almost like a pill
instead of a slightly rounded rectangle. This showed me the difference
between the two ways of customizing the UI: changing something inside
`ThemeData` styles **every** widget of that type in the whole app at once,
while putting a `style:` on a single widget only changes that one widget.

---

## 4. Answers to the ten review questions

**1. What is the difference between a StatelessWidget and a StatefulWidget?
Give one example of each from this lab.**

A `StatelessWidget` is a widget whose appearance never changes after it has
been drawn. It only needs a `build()` method that returns the widgets to
show, and Flutter can reuse the same instance over and over. A
`StatefulWidget` is a widget whose data can change while the app is running,
so it has to be able to rebuild itself when that happens. From this lab,
`ProfileCard` in Activity 1 and `WeatherPage` in Activity 3 are
`StatelessWidget`s — the text and the boxes are fixed. `WaterTrackerPage` in
Activity 2 is a `StatefulWidget` because the number of glasses changes every
time I tap a button.

**2. Why is a StatefulWidget written as two classes? What does each class do?**

Because the widget itself must stay immutable while the data it shows is
allowed to change. The public class (for example `WaterTrackerPage`) extends
`StatefulWidget` and has no `build()` of its own; its only job is
`createState()`, which creates and returns the second class. The second class
(the `State`) extends `State<WaterTrackerPage>` and holds the variable
`_glasses`, which is the data that changes. The `State` class owns the
`build()` method that draws the screen from that data. Keeping the two
separate means the widget can still be `const` and be rebuilt cheaply, while
the mutable data lives in the `State` object.

**3. In Activity 2, what happened when you changed `_glasses` outside
`setState()`? Why?**

The number on the screen did not change when I tapped **+**. `setState()` is
the method that tells Flutter that the state has changed and that the screen
must be redrawn. If the variable is changed outside of it, the value in memory
changes but Flutter never calls `build()` again, so the old number is still
what you see. The change only became visible later, the next time something
else triggered a rebuild.

**4. Looking at the Debug Console in Activity 2, when is `build()` called?**

`build()` is called every time the screen has to be drawn: once when the app
first opens, and then again after every change that goes through
`setState()`. In the Debug Console I could see one new
`build() called: N glasses` line appear after each tap on **+** or **−**, and
the number in the line always matched the number shown on the screen.

**5. Explain the main axis and the cross axis of a Row and of a Column.**

The main axis is the direction the children are placed in, and the cross axis
is the direction perpendicular to it. For a `Row` the main axis is horizontal
(left to right) and the cross axis is vertical. For a `Column` it is the
opposite: the main axis is vertical (top to bottom) and the cross axis is
horizontal. This is why `mainAxisAlignment` and `crossAxisAlignment` seem to
swap meaning between the two — in the `Column` in Activity 2 I used
`mainAxisAlignment: MainAxisAlignment.center` to centre the children
vertically, and in the header `Row` of Activity 3 I used
`crossAxisAlignment: CrossAxisAlignment.start` to line the city name up with
the left edge.

**6. In Activity 3, what happened when you removed `Expanded` from a
`StatBox`? What does `Expanded` do?**

The three boxes stopped being the same width. `Expanded` is a widget that
takes up all the space that is left in the main axis, and it divides that
space with the other `Expanded` children in the same `Row`. Because each of
the three boxes was wrapped in `Expanded`, the row gave each one an equal
share of the width, and the boxes stayed aligned whatever their content was.
When I removed it from one box, that box was sized by its own content
instead, the other two split the remaining space between them, and the row
no longer looked even.

**7. Why do we use `GridView.builder` for the menu instead of a `Column` with
many children?**

A `GridView.builder` only builds the widgets that are actually on the screen.
`itemBuilder` is called for each visible card as it scrolls into view and the
old ones are discarded, so a long menu stays fast and uses little memory. A
`Column` with many children would build every card at once, which is slower
and would eventually make the app lag. The `GridView` also gives the two
column layout for free through
`SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)`, and
`Expanded` gives it whatever height is left in the `Column`.

**8. How do `Stack` and `Positioned` create the Best seller badge in
Activity 4?**

A `Stack` draws its children on top of one another instead of placing them
side by side, and the first child is at the bottom. In `MenuCard` the
`Center` with the icon, name and price is the first child, so it sits at the
bottom of the stack, and the badge is added after it, so it is painted on
top. `Positioned` then pins that badge to a corner of the stack using
`top: 8, left: 8` instead of letting it be placed by the stack's alignment.
The badge is only added when the item is a best seller, using Dart's
collection-`if` (`if (item.bestSeller) Positioned(...)`). The same idea is
used in the banner, where the faded café icon is pushed partly outside the
banner with the negative values `right: -10, bottom: -20` and the `Stack`
clips whatever sticks out.

**9. What is the difference between customizing with `ThemeData` and with a
style on one widget? Give one example of each from Activity 5.**

`ThemeData` customizes the whole app: every widget of that kind picks the
style up automatically, wherever it is used, and it is built once and shared.
A style on a single widget only changes that one widget and nothing else.
In Activity 5, `buildTheme()` sets `elevatedButtonTheme` with
`ElevatedButton.styleFrom(...)`, and every `ElevatedButton` in the app
inherits the rounded corners and the extra padding — one line changed the
look of the button. On the other hand, the `Text('My skills', style:
Theme.of(context).textTheme.headlineSmall)` is the theme route, while a widget
such as `Text('Next hours', style: TextStyle(fontSize: 20, fontWeight:
FontWeight.bold))` in Activity 3 is the single-widget route: that style
belongs to that one `Text` and does not affect anything else.

**10. When you flip the dark-mode switch in Activity 5, which widget holds
the state, and how does the change reach `MaterialApp`?**

The state is held by `_ThemeDemoAppState`, the `State` object of
`ThemeDemoApp`, in its `bool _isDark` variable. The switch itself is in
`SettingsPage`, which is a `StatelessWidget` and only receives the value and
a callback: `isDark` is passed in through the constructor and
`onDarkChanged` is a `ValueChanged<bool>` function. When the user flips the
switch, `SettingsPage` calls `onDarkChanged`, which is really
`_setDark` in the parent, and that method changes `_isDark` inside
`setState()`. The parent's `build()` then runs again and rebuilds the
`MaterialApp` with `themeMode: _isDark ? ThemeMode.dark : ThemeMode.light`,
so `MaterialApp` picks the matching theme from `theme` or `darkTheme` and
every widget below it is rebuilt with the new colours. The state is
deliberately kept in the parent instead of the page — that pattern is called
lifting state up.
