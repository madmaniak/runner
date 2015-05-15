require 'rubygems'
require 'bundler/setup'
require 'ostruct'
require 'colorize'

class Runner

  class << self

    attr_reader :document

    def title(description) # kind of initializer, need to be used once in class
      @current_task = [] << @document = []
      new_line :title, description
    end

    def task(description)
      new_line :task, description, task_steps = []
      @current_task << task_steps
      yield
      @current_task.pop
    end

    def description(description)
      new_line :description, description
    end

    def step(description)
      new_line :step, description, ->{ yield }
    end

    def run
      walk ->(line){
        puts decorate(line, :run)
        line.code.call if line.type == :step
      }
    end

    def doc
      walk ->(line){
      }
    end

    private

    def new_line(type, description, code = nil)
      current_task << OpenStruct.new(type: type, description: description, code: code)
    end

    def current_task
      @current_task.last
    end

    def walk(job, list = @document)
      list.each do |line|
        job.call(line)
        walk(job, line.code) if line.code.is_a? Array
      end
    end

    def decorate(line, mode)
      description = line.description

      if mode == :run
        case line.type
        when :title then description.white.on_blue
        when :task then description.light_blue
        when :description then description.magenta
        when :step then description.light_magenta
        end
      elsif mode == :doc
        case line.type
        when :title then "# #{description}"
        when :task then "## #{description}"
        when :description then "_#{description}_"
        when :step then description
        end
      end
    end

  end

end
