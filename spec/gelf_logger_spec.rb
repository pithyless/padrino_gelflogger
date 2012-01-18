require 'spec_helper'

describe Padrino::GelfLogger do
  include RR::Adapters::MiniTest
  padrino_levels = [:fatal, :error, :warn, :info, :debug, :devel]

  before do
    @logger = Padrino::GelfLogger.new('0.0.0.0', 12201, 'WAN', :facility => 'Padrino::GelfLogger', :level => GELF::DEBUG)
  end

  it "#fatal" do
    mock(@logger).notify_with_level(4, "test")
    @logger.fatal "test"
  end

  it "#error" do
    mock(@logger).notify_with_level(3, "test")
    @logger.error "test"
  end

  it "#warn" do
    mock(@logger).notify_with_level(2, "test")
    @logger.warn "test"
  end

  it "#info" do
    mock(@logger).notify_with_level(1, "test")
    @logger.info "test"
  end

  it "#debug" do
    mock(@logger).notify_with_level(0, "test")
    @logger.debug "test"
  end  

  it "#devel" do
    mock(@logger).notify_with_level(0, "test")
    @logger.devel "test"
  end

  it '#bench' do
    mock(@logger).notify_with_level(0, {short_message: 'action 20.0000ms: message', _duration: 20.0, _action: 'action'})
    Timecop.freeze(Time.local(2012, 12, 20, 20, 12, 20)) do
      @logger.bench("action", Time.local(2012, 12, 20, 20, 12, 00), "message", level=:debug, color=:yellow)
    end
  end

  it 'should respond to #log_static for sinatra and not log anything' do
    assert_respond_to @logger, :log_static
  end

  it 'should respond to #log and not log anything' do
    assert_respond_to @logger, :log
  end

end