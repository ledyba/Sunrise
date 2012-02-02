# -*- encoding: utf-8 -*-
require 'rake/clean'

RACC="racc"
RUBY="ruby"

SRCS = FileList["**/*.racc"]
GENS = SRCS.ext("rb");
task :default => "test"

task "test" => GENS do
	sh "#{RUBY} main.rb test.asm"
end

task "reload" => ["clean", "test"]

CLEAN.include(GENS)

rule '.rb' => '.racc' do |t|
  sh "#{RACC} #{t.source} -o #{t.name}"
end
