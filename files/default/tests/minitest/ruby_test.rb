require File.expand_path('../support/helpers', __FILE__)

describe 'ortho_review' do
  include Helpers::Ortho_review_cookbook

  # Example spec tests can be found at http://git.io/Fahwsw
  describe 'ruby' do
    it 'must have bundler' do
      result = assert_sh("gem list -l bundler")
      assert_includes result, "bundler"
    end
  end
end
