require_relative 'helper'

describe NameDetector do
  it "can find simple names" do
    NameDetector.extract_names('Jim Smith').must_equal ['Jim Smith']
  end

  it "will not find non-names" do
    NameDetector.extract_names('and the news at five is..').must_be_nil
  end
end
