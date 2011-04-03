require "ripper"

module DBR
  class RubyParser < Ripper
    attr_reader :comments

    def initialize(source, filename)
      super
      @comments = {}
    end

    def on_comment(comment)
      comment = comment.gsub(/^\#{1,}\s{0,1}/, "").chomp
      append_comment = @comments[lineno - 1]

      if append_comment && @comments_last_column == column
        @comments.delete(lineno - 1)
        comment = append_comment + "\n" + comment
      end

      @comments[lineno] = comment
      @comments_last_column = column
    end
  end
end
