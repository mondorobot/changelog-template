require 'rake/file_list'
require 'pathname'

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :bower_components, File.join(root, 'bower_components')

configure :build do
  activate :minify_javascript
  activate :minify_css
  activate :asset_hash
  activate :relative_assets
end

after_configuration do
  sprockets.append_path bower_components

  sprockets.import_asset 'modernizr/modernizr.js'
end
