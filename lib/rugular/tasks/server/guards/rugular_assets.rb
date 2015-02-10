class RugularAssets
  def self.copy_asset(file)
    FileUtils.mkdir('.tmp/assets') unless File.directory? '.tmp/assets'
    FileUtils.cp(file, ".tmp/assets/#{File.basename(file)}")
  end

  def self.delete_asset(file)
    FileUtils.rm(".tmp/assets/#{File.basename(file)}")
  end
end
