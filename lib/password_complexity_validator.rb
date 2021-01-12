# frozen_string_literal: true

require 'zxcvbn'

class PasswordComplexityValidator < ActiveModel::Validator
  def validate(record)
    return if record.password.blank?

    result = Zxcvbn::Tester.new.test(record.password)
    min_score = options[:min_score] || 2
    return unless result.score < min_score

    warning = result.feedback.warning
    suggestions = result.feedback.suggestions.join("\n")
    record.errors.add(:password, "is not secure: #{warning}\n#{suggestions}")
  end
end
