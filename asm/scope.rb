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
			self.appendConstant(routine.nameIdent, routine);
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
		if resolved.canReduce
			return resolveConstant(resolved);
		else
			return  resolved;
		end
	end
end
