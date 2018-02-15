module TemplatingEngine

  def herb(file, context)
    text = File.read file
    text = convert text
    execute(text, context)
  end

  private

  def convert(string)
    ("output = \"" + string.tr("\"", "'"))
      .delete("\n")
      .gsub('~%=', "\"\noutput +=")
      .gsub('~%', "\"\n")
      .gsub('%~', "\noutput += \"")
      .+ "\"\nreturn output"
  end

  def execute(string, context)
    eval(string)
  end

end
