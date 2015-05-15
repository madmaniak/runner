require 'rubygems'
require 'bundler/setup'

class Runner

  TYPE = 0
  DESCRIPTION = 1
  CODE = 2

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
        puts line[DESCRIPTION]
        line[CODE].call if line[TYPE] == :step
      }
    end

    def documentation
      walk ->(line){
      }
    end

    private

    def new_line(*structure)
      current_task << structure # type, description, code/subtasks
    end

    def current_task
      @current_task.last
    end

    def walk(job, list = @document)
      list.each do |line|
        job.call(line)
        walk(job, line[CODE]) if line[CODE].is_a? Array
      end
    end

  end

end
