require "spec_helper"

describe App do

  def app
    App.new
  end

  include Rack::Test::Methods

  context "get /" do
    subject { get "/" }
    it { should be_ok }
  end

  context "get /pages" do
    subject { get "/pages" }
    it { should be_ok }
  end

end
