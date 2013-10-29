require 'bundler/gem_tasks'

task :deploy, :arg1 do |t, args|
  `rake install`
  `git add -A`
  `git commit -m '#{args.arg1}'`
  `git push`
end