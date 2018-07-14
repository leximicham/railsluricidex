class Runit
  def initialize(ip, username, keyfile)
	@ssh = Net::SSH.new(ip: ip, user: username, pubkey: keyfile)
  end

  def status(service)
    output = @ssh.do!("sudo sv status #{Shellwords.escape(service)}")
	  status = {
	     name: output.size, #parse these later
	     uptime: output.reverse,
	     running: output.upcase,
	  }
	status
  end

  def start(service)
	output = @ssh.do!("sudo sv start #{Shellwords.escape(service)}")
  end

  def stop(service)
	output = @ssh.do!("sudo sv stop #{Shellwords.escape(service)}")
  end
end
