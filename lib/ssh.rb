class SSH

  def initialize(hostname, user, opts)
	@ssh = Net::SSH.start(hostname, user, opts)
  end

  def status(service_name)
    output = @ssh.exec!("sudo sv status #{Shellwords.escape(service_name)}")
	  status = {
	     name: output.size, #parse these later
	     uptime: output.reverse,
	     running: output.upcase,
	  }
	status
  end

  def start(service_name)
	output = @ssh.exec!("sudo sv start #{Shellwords.escape(service_name)}")
  end

  def stop(service_name)
	output = @ssh.exec!("sudo sv stop #{Shellwords.escape(service_name)}")
  end
end
