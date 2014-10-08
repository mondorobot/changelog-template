namespace :icons do

  directory 'tmp/iconfont'

  desc "Update icons from Icomoon .zip file"
  task :update, [:zipfile] => [:'tmp/iconfont'] do |t, args|
    begin
      # Set absolute zipfile path in ~/Downloads
      zipfile = File.join(ENV['HOME'], 'Downloads', args[:zipfile].shellescape)

      # Set some dir vars
      root = File.join(File.dirname(__FILE__), '..', '..')
      tmp_dir = File.join(root, 'tmp', 'iconfont')
      fonts_dir = File.join(root, 'source', 'fonts')
      css_dir = File.join(root, 'source', 'stylesheets', 'components')

      # Create the tmp folder for extracted zip
      unless File.directory? tmp_dir
        system "mkdir #{tmp_dir}"
      end

      # Unzip font into tmp folder
      system "unzip -u #{zipfile} -d #{tmp_dir}"

      # Copy the font files
      Dir.glob(File.join(tmp_dir, 'fonts', '*')) do |file|
        puts "Copying #{file} to #{fonts_dir}"
        system "cp #{file} #{fonts_dir}"
      end

      # Copy the stylesheet
      puts 'Copying the stylesheet'
      stylesheet = File.join(css_dir, '_icons.css.scss')
      system "cp #{File.join(tmp_dir, 'style.css')} #{stylesheet}"

      # Replace the font urls in the stylesheet
      puts 'Updating font URLs in stylesheet'
      stylesheet_content = File.read(stylesheet)
      stylesheet_content.gsub!("url('fonts/", "font-url('")
      File.open(stylesheet, 'w') do |file|
        file.write(stylesheet_content)
      end

    ensure
      puts 'Deleting source folder'
      if File.directory? tmp_dir
        system "rm -rf #{tmp_dir}"
      end
    end
    puts "DONE"
  end

end
