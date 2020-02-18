class ActLocally

  def initialize(ip, server)
  end

  def save(ip, port)
    `scripts/rcon -Phellotoday -a#{ip} -p#{Shellwords.escape(port)} SaveWorld`
  end

  def last_saved_at(server, friendly_name)
    saves = Dir["/mnt/nas/ARK/saves/#{server}/#{Shellwords.escape(friendly_name)}/*.ark"]
    return "Multiple saves found in #{server}/#{Shellwords.escape(friendly_name)}, something is probably wrong." unless saves.size == 1
    File.mtime(saves.first)
  end
end
