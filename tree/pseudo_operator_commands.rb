# -*- encoding: utf-8 -*-
require File.dirname(__FILE__)+"/tree.rb";
require File.dirname(__FILE__)+"/pseudo_operator.rb";
module ParserInner
end
module ParserInner::Tree
end
module ParserInner::Tree::PseudoOperator
	CommandTable = {
		#:Command => ClassName
	};
end