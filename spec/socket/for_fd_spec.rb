require File.expand_path('../../fixtures/classes', __FILE__)
require 'socket'

describe "Socket.for_fd" do
  before :each do
    @server = TCPServer.new("127.0.0.1", SocketSpecs.port)
    @client = TCPSocket.open("127.0.0.1", SocketSpecs.port)
  end

  after :each do
    @socket.shutdown Socket::SHUT_RD if @socket
    @client.shutdown Socket::SHUT_WR

    @host.close if @host
    @server.close
  end

  it "creates a new Socket that aliases the existing Socket's file descriptor" do
    @socket = Socket.for_fd(@client.fileno)
    @socket.fileno.should == @client.fileno

    @socket.send("foo", 0)
    @client.send("bar", 0)

    @host = @server.accept
    @host.read(3).should == "foo"
    @host.read(3).should == "bar"
  end
end
