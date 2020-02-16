class Save

  def initialize(ip, port)
  end

  def save
    `scripts/rcon -Phellotoday -a#{Shellwords.escape(ip)} -p#{Shellwords.escape(port)} SaveWorld`
  end

class LastSavedAt

  def initialize(game, server)
  end

  def last_saved_at
    saves = Dir["/mnt/nas/ARK/saves/#{Shellwords.escape(server)}/#{Shellwords.escape(game)}/*.ark"]
    return "Multiple saves found, something is probably wrong." unless saves.size == 1
    File.mtime(saves.first)
  end
