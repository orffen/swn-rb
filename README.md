# SWN Toolbox

## Introduction

The SWN Toolbox is a collection of Ruby scripts designed to speed up random
generation of various Stars Without Number things. It is aimed primarily
at Game Masters.

The scripts are written in Ruby; you'll need an installation of Ruby on your
system to run them. A Windows Ruby installer is available at 
<http://www.rubyinstaller.org>.

The SWN Toolbox is [hosted on GitHub](https://github.com/orffen/swn).

## Installation

No installation is required; simply extract the file into a folder of your
choice. The .rb files can be run directly from the command-line:

- ruby alien.rb

If you're running in a Windows environment, you most likely don't have
Ruby installed. You can download Ruby for free from
<http://www.rubyinstaller.org>.

## Usage

In this release, each script is designed to be run directly from the
command-line.

Every script in the collection supports a single command-line argument:

- a number, which specifies the amount of items to generate.

For example: "ruby alien.rb 3" will generate 3 alien races.

## Extending the SWN Toolbox

The scripts use the tables in the subdirectory, which are simple JSON files.

You can edit them to add more entries to be randomly-selected by the scripts.

## License

The SWN Toolbox

Copyright (c) 2014 Steve Simenic <orffen@orffenspace.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
