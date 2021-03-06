require 'zxcvbn'

class PasswordComplexityValidator < ActiveModel::Validator
  def validate(record)
    return if record.password.blank?
    result = Zxcvbn::Tester.new.test(record.password)
    min_score = options[:min_score] || 3
    record.errors.add(:password, :complexity) if result.score < min_score
  end
end
