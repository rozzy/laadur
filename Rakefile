require 'bundler/gem_tasks'
require 'version'

task :deploy, :arg1 do |t, args|
  `rake install`
  `git add -A`
  v = File.read("version").to_version
  v.bump!
  File.open('version', 'w') { |file| file.write(v.to_s) }
  `git commit -m '#{args.arg1}'`
  `git push`
end