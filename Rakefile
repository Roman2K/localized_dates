require 'spec/rake/spectask'

desc "Default: run specs."
task :default => :spec

desc "Run the specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--colour --format progress --loadby mtime --reverse']
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Generate RDoc documentation"
task :rdoc do
  system("rm -rf doc && rdoc -S -N -m README -c UTF-8 README lib && open doc/index.html")
end
