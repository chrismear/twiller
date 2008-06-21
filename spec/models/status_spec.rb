require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Status, "association with author" do
  it "should find a Person" do
    @status = Status.new(:author_id => 1)
    Person.should_receive(:find).with(1, anything)
    @status.author
  end
end
