require File.expand_path('../support/helpers', __FILE__)

describe 'ortho_review' do
  include Helpers::Ortho_review_cookbook

  # Example spec tests can be found at http://git.io/Fahwsw
  describe 'capistrano' do
    it 'should create the application directory' do
      directory(node['ortho_review']['application_path']).must_exist.with(:owner, node['ortho_review']['account'])
    end
    
    it 'should create the shared directory' do
      directory(node['ortho_review']['shared_path']).must_exist.with(:owner, node['ortho_review']['account'])
    end
    
    it 'should create the bower_components directory' do
      directory(bower_components_dir).must_exist.with(:owner, node['ortho_review']['account'])
    end
  end
end
