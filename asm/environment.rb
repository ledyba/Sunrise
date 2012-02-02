# -*- encoding: utf-8 -*-
module Asm
end
class Asm::Environment
	def initialize()
		@routines = [];
		@routineIndex = {};
		@constants = {};
	end
	def appendRoutine(routines)
		for routine in routines
			if @routineIndex.has_key? routine.to_sym;
				raise "Routine: \"#{routine}\" already defined.";
			end
			@routineIndex[routine.to_sym] = @routines.size
			@routines << routine;
		end
	end
	def getRoutine(name)
		unless @routineIndex.has_key? name
			return nil;
		end
		return @routines[@routineIndex[name]];
	end
	def appendConstant(identifer, val)
		if @constants.has_key? identifer.to_sym;
			raise "Already defined: #{identifer}";
		end
		@constants[identifer.to_sym] = val;
		return 
	end
	def resovleConstant(identifer)
		unless @constants.has_key? identifer.to_sym
			raise "Not defined: #{identifer}";
		end
		resolved = @constants[identifer.to_sym];
		if resolved.canReduce
			return resolveConstant(resolved);
		else
			return  resolved;
		end
	end
	
end
