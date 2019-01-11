class WordReader
  def read_from_args
    return ARGV[0]
  end

  def read_from_file(file_name)
    unless File.exist?(file_name)
      return nil
    end

    file = File.new(file_name, "r:UTF-8")
    lines = file.readlines
    file.close

    return lines.sample.chomp
  end
end
