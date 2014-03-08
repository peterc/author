require 'author/name_detector'
require 'author/html_name_finder'
require 'author/extractor'

module Author
  LIB_ROOT = File.join(__dir__, '..')
  NAMES = File.readlines(File.join(LIB_ROOT, 'data', 'names.txt')).map(&:chomp)
  STOPWORDS = File.readlines(File.join(LIB_ROOT, 'data', 'stopwords.txt')).map(&:chomp)
  TITLES = File.readlines(File.join(LIB_ROOT, 'data', 'titles.txt')).map(&:chomp)
  WORDNAMES = File.readlines(File.join(LIB_ROOT, 'data', 'wordnames.txt')).map(&:chomp)
end
