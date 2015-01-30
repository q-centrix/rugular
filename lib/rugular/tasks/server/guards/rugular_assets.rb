class RugularAssets
  def self.copy_image(file)
    FileUtils.mkdir('.tmp/images') unless File.directory? '.tmp/images'
    FileUtils.cp(file, ".tmp/images/#{File.basename(file)}")
  end

  def self.copy_font(file)
    FileUtils.mkdir('.tmp/fonts') unless File.directory? '.tmp/fonts'
    FileUtils.cp(file, ".tmp/fonts/#{File.basename(file)}")
  end

  def self.delete_image(file)
    FileUtils.rm(".tmp/images/#{File.basename(file)}")
  end

  def self.delete_font(file)
    FileUtils.rm(".tmp/fonts/#{File.basename(file)}")
  end
end
