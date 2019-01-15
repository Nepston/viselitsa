class WordReader
  def read_from_args
    ARGV[0]
  end

  def read_from_file(file_name)
    return unless File.exist?(file_name)
    lines = File.readlines(file_name, encoding: "r:UTF-8")
    lines.sample.chomp
  end
end
