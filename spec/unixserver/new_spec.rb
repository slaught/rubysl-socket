require File.expand_path('../shared/new', __FILE__)

describe "UNIXServer.new" do
  it_behaves_like :unixserver_new, :new
end
