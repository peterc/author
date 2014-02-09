require 'minitest/autorun'
require 'minitest/reporters'

require 'author'

#begin; require 'turn'; rescue LoadError; end   # Only if it's available..

Minitest::Reporters.use!

include Author
CORPUS_DIR = File.join(__dir__, "/corpus")
