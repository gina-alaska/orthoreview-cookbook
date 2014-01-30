module Helpers
  module Ortho_review_cookbook
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
    
    def sunspot_config_file(app = 'ortho_review')
      File.join(node[app]['shared_path'], 'config/sunspot.yml')
    end
    
    def secret_token_file(app = 'ortho_review')
      File.join(node[app]['shared_path'], 'config/initializers/secret_token.rb')
    end
    
    def bundle_config_file(app = 'ortho_review')
      File.join("/home", node[app]['account'], ".bundle/config")
    end
    
    def bower_components_dir(app = 'ortho_review')
      File.join(node[app]['shared_path'], 'vendor/assets/bower_components')
    end
  end
end
