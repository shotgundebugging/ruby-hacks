module MethodProfiler
  def self.profile_methods(klass, *methods)
    methods.each do |method_name|
      original_method = klass.instance_method(method_name)

      klass.define_method(method_name) do |*args, &block|
        start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        result = original_method.bind(self).call(*args, &block)
        end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        puts "#{method_name} took #{(end_time - start_time).round(4)} seconds"
        result
      end
    end
  end
end

