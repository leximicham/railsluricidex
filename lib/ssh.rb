class RunitParser
  attr_accessor :name, :pid, :status, :uptime

  VALID_STATUSES = ["run", "down", "finish"]
  RUNNING_STATUSES = ["run", "finish"]

  def initialize(message)
    parts = message.split(" ")
    @status = parts[0].gsub(/:/, '')
    @name = parts[1].gsub(/:/, '')
    if self.running?
      @pid = parts[3].gsub(/\)/, '').to_i
      @uptime = parts[4].gsub(/s;/, '').to_i
    else
      @uptime = parts[2].gsub(/s;/, '').to_i
    end

    raise "Unable to parse output" unless VALID_STATUSES.include?(@status)
  end

  def running?
    RUNNING_STATUSES.include?(@status)
  end
end

class SSH
  def initialize(hostname, user, opts)
	@ssh = Net::SSH.start(hostname, user, opts)
  end

  def status(service_name)
    output = @ssh.exec!("sudo sv status #{Shellwords.escape(service_name)}")
    RunitParser.new(output)
  end

  def start(service_name)
	output = @ssh.exec!("sudo sv start #{Shellwords.escape(service_name)}")
  end

  def stop(service_name)
	output = @ssh.exec!("sudo sv stop #{Shellwords.escape(service_name)}")
  end
end
