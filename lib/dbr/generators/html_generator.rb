require "slim"
require "fileutils"
require "coderay"
require "kramdown"

class Object
  def html_safe?
    false
  end
end

class String
  def html_safe
    SafeString.new(self)
  end
end

class SafeString < String
  def html_safe?
    true
  end
end

module DBR
  class HtmlGenerator
    class Context
      def initialize(generator, object)
        @generator, @object = generator, object
      end

      undef_method :public_methods
      undef_method :protected_methods

      def method_missing(method, *args)
        case
        when @object.respond_to?(method) then @object.send(method, *args)
        when @generator.respond_to?(method) then @generator.send(method, *args)
        else super
        end
      end
    end

    TEMPLATE_PATH = File.expand_path("../../../templates/html", File.dirname(__FILE__))
    OUTPUT_PATH = "doc"

    def initialize(context)
      @context = context
    end

    def generate
      FileUtils.mkdir_p(OUTPUT_PATH)
      FileUtils.copy("#{TEMPLATE_PATH}/assets/style.css", OUTPUT_PATH)

      File.open "#{OUTPUT_PATH}/index.html", "w+" do |file|
        file.write render_template(@context, "index")
      end

      @context.classes.each do |class_definition|
        File.open "#{OUTPUT_PATH}/#{path_for(class_definition)}", "w+" do |file|
          file.write render(class_definition)
        end
      end
    end

    def render(subject)
      result = if subject.respond_to? :each
        subject.collect { |child| render_template child }.join
      else
        render_template subject
      end
      SafeString.new(result)
    end

    def xformat(content)
      content = content.to_s
      content.gsub! %r{\+([\w=?!]+)\+}, "`\\1`"
      content.gsub! %r{<tt>(.*?)</tt>}, "`\\1`"
      content.gsub! %r{^ {2}}m, "    "
      Kramdown::Document.new(content, :coderay_line_numbers => nil).to_html.html_safe
    end

    def path_for(subject)
      id = if subject.name
        subject.name.downcase.tr(":", "_")
      else
        subject.object_id
      end
      "#{subject.type}_#{id}.html"
    end

    private

    def render_template(definition, name = definition.type)
      Slim::Template.new(TEMPLATE_PATH + "/#{name}.slim", :use_html_safe => true).render(Context.new(self, definition))
    end
  end
end
