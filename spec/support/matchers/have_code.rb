require 'rspec/expectations'

RSpec::Matchers.define :have_code do |expected|
  match do |actual|
    expect(actual).to respond_to :code
    expect(actual.code).to eq expected.to_sym
  end

  failure_message do |actual|
    if actual.respond_to?(:code)
      "expected that code \"#{actual.code}\" would equal \"#{expected.to_sym}\""
    else
      "expected that #{actual.inspect} (#{actual.class}) would respond to `code`"
    end
  end
end
