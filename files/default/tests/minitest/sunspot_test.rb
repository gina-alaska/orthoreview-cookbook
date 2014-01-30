require File.expand_path('../support/helpers', __FILE__)

describe 'ortho_review' do
  include Helpers::Ortho_review_cookbook

  # Example spec tests can be found at http://git.io/Fahwsw
  describe 'sunspot' do    
    it 'should create the sunspot config' do
      file(sunspot_config_file).must_exist.with(:owner, node['ortho_review']['account'])
    end    
  end
end
