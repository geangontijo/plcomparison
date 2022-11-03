class Api::CreateProjectController < ApplicationController
  respond_to? :json
  skip_before_action :verify_authenticity_token

  def store
    errors = []
    possible_scopes = %w[BACKEND FRONTEND]
    possible_objectives = %w[EMERGENCY_PROJECT TEST_PROJECT]

    def convert_enum_message (possible_values)
      possible_values.map { |v| "\"#{v}\"" }.join(',')
    end

    if !params['scope'].kind_of?(Array) || (params['scope'].kind_of?(Array) && params['scope'].select { |scope| possible_scopes.include?(scope) }.empty?)
      errors.push({
                    message: "param \"scope\" must be a array<" + convert_enum_message(possible_scopes) + ">."
                  })
    end

    unless possible_objectives.include?(params['objective'].to_s)
      errors.push({
                    message: "param \"objective\" should be the values " + convert_enum_message(possible_objectives) + '.'
                  })
    end

    if (params['performance_points'] || 0).to_i < 1 || (params['performance_points'] || 0).to_i > 100
      errors.push({
                    message: "param \"performance_points\" should be between 1 and 100."
                  })
    end

    if (params['learning_difficulty_points'] || 0).to_i < 1 || (params['learning_difficulty_points'] || 0).to_i > 100
      errors.push({
                    message: "param \"learning_difficulty_points\" should be between 1 and 100."
                  })
    end

    unless errors.empty?
      render json: {
        errors: errors
      }
      nil
    end

  end
end
