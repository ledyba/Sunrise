# -*- encoding: utf-8 -*-
require 'rake/clean'

RACC="racc"

SRCS = FileList["**/*.racc"]
GENS = SRCS.ext("rb");
task :default => "hello"


task :default => ['hello','glpgs','workshop1', 'workshop2']

desc "build and test, default"
task "hello" => GENS do
	ruby "main.rb", "__src__/hello.asm", "__src__/font.chr", "__bin__/hello.nes"
end

task "glpgs" => GENS do
	ruby "main.rb", "__src__/glpgs.asm", "__src__/font.chr", "__bin__/glpgs.nes"
end

task "workshop1" => GENS do
	ruby "main.rb", "__src__/workshop_sample.asm", "__src__/font.chr", "../chisa/universe/__roms__/workshop/rom1.nes"
end

task "workshop2" => GENS do
	ruby "main.rb", "__src__/workshop_sample2.asm", "__src__/chara.chr", "../chisa/universe/__roms__/workshop/rom2.nes"
end

desc "clean builds, then Hello world!"
task "reload" => ["clean", "hello"]

CLEAN.include(GENS)

rule '.rb' => '.racc' do |t|
  sh "#{RACC} #{t.source} -o #{t.name}"
end
