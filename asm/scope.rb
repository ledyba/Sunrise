# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/../tree/tree.rb";
module Asm
end
class Asm::Scope
	def initialize(code_base)
		@code_base = code_base
		@routines = [];
		@routineAddrTable = {};
		@fairy = ::Asm::RoutineFairy.new(self);
		@constants = {};
		@config = {};
	end
	def setConfig(name, value)
		name = name.to_sym
		if @config.has_key? name
			raise "Already defined config: #{name} = #{@config[name]}(=>#{value})";
		end
		@config[name] = value;
	end
	attr_reader :routines, :fairy
	def <<(routines)
		@routines += routines;
	end
	def has_routine?(name)
		return @routines.any?{|routine| routine.to_sym == name.to_sym}
	end
	def fixRoutines()
		@fairy.freeze
		for routine in @routines
			addr = @fairy.resolveOffset(routine)+@code_base
			imm_node = ::ParserInner::Tree::ImmediateNode.new(addr.to_s(16), addr.to_s(16), 16);
			appendConstant(routine.nameIdent, imm_node);
			@routineAddrTable[routine.to_sym] = addr
			routine.fix_addr(addr)
		end
	end
	def resolveConfig(name)
		return @config[name.to_sym];
	end
	def resolveRoutineAddr(routine)
		return @routineAddrTable[routine.to_sym]
	end
	def appendConstant(identifer, val)
		if @constants.has_key? identifer.to_sym;
			raise "Already defined: #{identifer}";
		end
		@constants[identifer.to_sym] = val;
		nil
	end
	def resolveConstant(identifer)
		unless identifer.needResolve
			return identifer
		end
		unless @constants.has_key? identifer.to_sym
			raise "Not defined: #{identifer}";
		end
		resolved = @constants[identifer.to_sym];
		if resolved.needResolve
			return resolveConstant(resolved);
		else
			return  resolved;
		end
	end
end
class Asm::RoutineFairy
	def initialize(scope)
		@scope = scope;
		@pass = 0;
		@minOffset = 0;
		@maxOffset = 0;
		@tempRoutineMinOffsets = {};
		@tempRoutineMaxOffsets = {};
	end
	def forward(min, max)
		raise "#{min} > #{max}" if min > max
		@minOffset += min;
		@maxOffset += max;
	end
	def start(routine)
		@tempRoutineMinOffsets[routine.to_sym] = @minOffset
		@tempRoutineMaxOffsets[routine.to_sym] = @maxOffset
	end
	def resolveDistance(routine)
		sym = routine.to_sym;
		unless @tempRoutineMinOffsets.has_key?(sym) && @tempRoutineMaxOffsets.has_key?(sym)
			return nil
		end
		rmin = @tempRoutineMinOffsets[sym];
		rmax = @tempRoutineMaxOffsets[sym];
		dist = [rmin-@minOffset, rmax-@minOffset, rmin-@maxOffset, rmax-@maxOffset].min_by{|t|
			-t.abs
		}
		return dist;
	end
	def resolveOffset(routine)
		unless frozen?
			raise "not fixed yet."
		end
		return @tempRoutineMaxOffsets[routine.to_sym];
	end
	def reset()
		@pass+=1;
		@minOffset = 0;
		@maxOffset = 0;
	end
	def allFixed()
		if @minOffset != @maxOffset
			return false
		end
		@tempRoutineMinOffsets.each_pair { |key,val|
			if @tempRoutineMaxOffsets[key] != val
				return false
			end
		}
		return true;
	end
	attr_reader :minOffset, :maxOffset, :pass, :scope
end

