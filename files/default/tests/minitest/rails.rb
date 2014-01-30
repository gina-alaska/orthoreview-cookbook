require File.expand_path('../support/helpers', __FILE__)

describe 'ortho_review' do
  include Helpers::Ortho_review_cookbook

  # Example spec tests can be found at http://git.io/Fahwsw
  describe 'site' do
    it 'should create the application directory' do
      directory(node['ortho_review']['application_path']).must_exist.with(:owner, node['ortho_review']['account'])
    end
    
    it 'should create the shared directory' do
      directory(node['ortho_review']['shared_path']).must_exist.with(:owner, node['ortho_review']['account'])
    end
        
    it 'should create the rails secret token config' do
      file(secret_token_file).must_exist.with(:owner, node['ortho_review']['account'])
    end    
    
    # it 'should create the rails database config' do
    #   file(database_config_file).must_exist.with(:owner, node['ortho_review']['account'])
    # end
    
    it 'should create the unicorn config' do
      file(unicorn_config_file).must_exist.with(:owner, node['ortho_review']['account'])
    end
    
    it 'should create the unicorn init script' do
      file(unicorn_init_file).must_exist
    end
    
    it 'should enable the unicorn service' do
      service("unicorn_ortho_review").must_be_enabled
    end
  end
end
