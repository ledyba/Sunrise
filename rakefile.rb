# -*- encoding: utf-8 -*-
require 'rake/clean'

RACC="racc"

SRCS = FileList["**/*.racc"]
GENS = SRCS.ext("rb");
task :default => "hello"

desc "build and test, default"
task "hello" => GENS do
	ruby "main.rb", "hello.asm"
	#sh "../Cycloa/Release/Cycloa.exe compiled.nes"
end

task "glpgs" => GENS do
	ruby "main.rb", "glpgs.asm"
	sh "../Cycloa/Release/Cycloa.exe compiled.nes"
end

desc "clean builds, then Hello world!"
task "reload" => ["clean", "hello"]

CLEAN.include(GENS)

rule '.rb' => '.racc' do |t|
  sh "#{RACC} #{t.source} -o #{t.name}"
end
