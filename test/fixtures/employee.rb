module MyApp
  class Employee
    def initialize(name, salary = nil)
      @name, @salary = name, salary
    end

    TITLES = ["Engineer", "Manager"]

    class << self
      def create(name)
        new(name, salary = 20_000)
      end
    end

    def self.inherited(subclass)
    end

    attr_reader :name

    attr_accessor :manager

    # The salary that is paid to
    # an employee.
    def salary(currency = "EUR", exchange_rate = 1)
      currency + (@salary.to_f / exchange_rate)
    end
    alias_method :wage, :salary
    alias_method :payment, :salary

    def managed?
      !!manager
    end

    def work(*args, &block)
      start_work
      block.call
    end

    protected

    def start_work
      task_one
      task_two
    end

    private

    def task_one
    end

    def task_two
    end

    class Task
    end
  end
end