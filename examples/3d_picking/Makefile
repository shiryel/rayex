.PHONY: test
test:
	mix compile --warnings-as-errors
	mix test
	mix format
	mix format --check-formatted
	mix credo --strict
	mix dialyzer
