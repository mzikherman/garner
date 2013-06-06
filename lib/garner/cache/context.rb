# Set up Garner configuration parameters
Garner.config.option(:context_key_strategies, {
  :default => [ Garner::Strategies::Context::Key::Caller ]
})

module Garner
  module Cache
    module Context

      # Instantiate a context-appropriate cache identity.
      #
      # @example
      #   garner.bind(current_user) do
      #     { count: current_user.logins.count }
      #   end
      # @return [Garner::Cache::Identity] The cache identity.
      def garner(&block)
        identity = Garner::Cache::Identity.new
        Garner.config.context_key_strategies.each do |strategy|
          identity = strategy.apply(identity, self)
        end

        block_given? ? identity.fetch(&block) : identity
      end
    end
  end
end
