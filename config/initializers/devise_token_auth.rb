# frozen_string_literal: true

DeviseTokenAuth.setup { |config| config.token_cost = Rails.env.test? ? 4 : 10 }
