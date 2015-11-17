# Code Climate Decorum Engine

[![Code Climate](https://codeclimate.com/github/noahd1/decorum/badges/gpa.svg)](https://codeclimate.com/github/decorum/curses)

`decorum` is a Code Climate engine that enforces Good Behavior in your source code. Behavior - like human behavior, not code behavior. To start, decorum looks for curse words in your source code.

You can run it on your command line using the Code Climate CLI, or on our hosted analysis platform.

### Installation

1. If you haven't already, [install the Code Climate CLI](https://github.com/codeclimate/codeclimate).
2. Run `codeclimate engines:enable decorum`. This command both installs the engine and enables it in your `.codeclimate.yml` file.
3. You're ready to analyze! Browse into your project's folder and run `codeclimate analyze`.

### How are the curse words defined?

Thank fucking Shutterstock for that:

https://github.com/shutterstock/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words
