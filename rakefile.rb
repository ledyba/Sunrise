# -*- encoding: utf-8 -*-
require 'rake/clean'

RACC="racc"

SRCS = FileList["**/*.racc"]
GENS = SRCS.ext("rb");
task :default => "test"

desc "build and test, default"
task "test" => GENS do
	ruby "main.rb", "test.asm"
end

desc "clean builds, then test"
task "reload" => ["clean", "test"]

CLEAN.include(GENS)

rule '.rb' => '.racc' do |t|
  sh "#{RACC} #{t.source} -o #{t.name}"
end
