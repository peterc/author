require_relative 'helper'

describe NameDetector do
  it "can find simple names" do
    NameDetector.extract_names('Jim Smith')[0][0].must_equal 'Jim Smith'
  end

  it "will not find non-names" do
    NameDetector.extract_names('and the news at five is..').must_be_nil
  end

  it "can find a best match" do
    NameDetector.new('My name is Jim Smith').best_match.must_equal 'Jim Smith'
  end

  it "can find a best match even under challenging circumstances" do
    text = %{We didn't start the Fire. It was always billy joel and so forth.}
    NameDetector.new(text).best_match.must_equal 'billy joel'
  end
end
