module ActionDispatch
  module Routing
    Mapper.class_eval do
      def resources_api(*args, &block)
        args << {} if args.size == 1
        args[1][:except] ||= []
        args[1][:except] = args[1][:except] | [:new, :edit]
        resources *args, &block
      end
    end
  end
end
