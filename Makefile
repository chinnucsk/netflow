PROJECT = netflow

ERL = erl
REBAR = rebar
DIALYZER = dialyzer

.PHONY: deps doc test

compile:
	@$(REBAR) compile

clean:
	@$(REBAR) clean

test: clean compile
	@$(REBAR) xref eunit

doc:
	@$(REBAR) doc

build-plt:
	@$(LIBS) $(DIALYZER) --build_plt --output_plt $(PROJECT).plt \
		--apps erts kernel stdlib

dialyze:
	@$(DIALYZER) --src src --plt $(PROJECT).plt \
		-Werror_handling -Wrace_conditions -Wunmatched_returns --no_native
