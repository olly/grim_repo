RSpec::Matchers.define :have_any do
  match {|enumerable| enumerable.any? }
end
