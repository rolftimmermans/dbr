module DBR
  class FileDefinition < Base
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def comment(line)
      parsed.comments[line - 1]
    end

    def source
      @source ||= File.read(path)
    end

    protected

    def parsed
      @parsed ||= RubyParser.new(source, path).tap do |parser|
        parser.parse
      end
    end
  end
end
