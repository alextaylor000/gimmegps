#!/usr/bin/env ruby
require File.expand_path('../../lib/cli', __FILE__)

Cli.new($ARGV[0] || Dir.pwd).output!
