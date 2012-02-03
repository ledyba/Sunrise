# -*- encoding: utf-8 -*-
module Asm
end
class Asm::Scope
	def initialize()
		@routines = [];
		@routineIndexTable = {};
		@constants = {};
	end
	attr_reader :routines
	def appendRoutines(routines)
		for routine in routines
			raise "Invalid type:#{routine.class}" unless routine.is_a? ::Parser::Tree::RoutineNode
			if @routineIndexTable.has_key? routine.to_sym;
				raise "Routine: \"#{routine}\" already defined.";
			end
			@routineIndexTable[routine.to_sym] = @routines.size
			@routines << routine;
			self.appendConstant(routine.nameIdent, nil);
		end
	end
	def appendConstant(identifer, val)
		if @constants.has_key? identifer.to_sym;
			raise "Already defined: #{identifer}";
		end
		@constants[identifer.to_sym] = val;
		nil
	end
	def resovleConstant(identifer)
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
class Asm::PrepareState
	def initialize(scope)
		@scope = scope;
		@minOffset = 0;
		@maxOffset = 0;
		@tempRoutineMinOffsets = {};
		@tempRoutineMaxOffsets = {};
	end
	def forward(min, max)
		raise "#{min} > #{max}" if min > max
		@minOffset += min;
		@maxOffset += max;
		puts "#{@minOffset}, #{@maxOffset}"
	end
	def startRoutine(routine)
		@tempRoutineMinOffsets[routine.to_sym] = @minOffset
		@tempRoutineMaxOffsets[routine.to_sym] = @maxOffset
	end
	def resolveDistance(routine)
		unless @tempRoutineMinOffsets.has_key?(routine.to_sym) || @tempRoutineMaxOffsets.has_key?(routine.to_sym)
			return nil
		end
		rmin = @tempRoutineMinOffsets[routine.to_sym];
		rmax = @tempRoutineMaxOffsets[routine.to_sym];
		dist = [rmin-@minOffset, rmax-@minOffset, rmin-@maxOffset, rmax-@maxOffset].min_by{|t|
			-t.abs
		}
		return dist;
	end
	def reset
		@minOffset = 0;
		@maxOffset = 0;
	end
	attr_reader :minOffset, :maxOffset
end

