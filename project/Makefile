#
# Targets
#

REBAR=`which rebar`

.PHONY: build

all: clean deps build

clean:
	@$(REBAR) clean

deps:
	@$(REBAR) get-deps

build:
	@$(REBAR) compile

test: build
	@$(REBAR) skip_deps=true eunit

package: build
	@$(REBAR) generate -f

console: package
	rel/{{projectid}}/bin/{{projectid}} console

doc:
	@$(REBAR) skip_deps=true doc

#
# Dialyzer
#

PLT=./plt/R14B04.plt

WARNINGS=-Werror_handling \
  -Wrace_conditions \
  -Wbehaviours \
  -Wunderspecs \
  -Wunmatched_returns

APPS=kernel stdlib sasl erts ssl \
  tools os_mon runtime_tools crypto \
  inets xmerl webtool snmp public_key \
  mnesia eunit syntax_tools compiler

build-plt: all
	@dialyzer --build_plt --output_plt $(PLT) \
	  --apps $(APPS) $(DEPS)

dialyzer: build
	@dialyzer ebin --plt $(PLT) $(WARNINGS)

#
# Typer
#

typer: build
	@typer --plt $(PLT) -I deps/ src/
