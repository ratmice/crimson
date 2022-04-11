test_inputs=$(wildcard test/pass/*.crimson)
test_output_tmp=$(patsubst %.crimson,%.out,$(test_inputs))
test_outputs:=$(subst test/pass/,test/output/,$(test_output_tmp))

test_fail_inputs=$(wildcard test/fail/*.crimson)
test_fail_output_tmp+=$(patsubst %.crimson,%.out,$(test_fail_inputs))
test_fail_outputs:=$(subst test/fail/,test/output/,$(test_fail_output_tmp))

test/output/%.out: test/pass/%.crimson src/crimson.l src/crimson.y
	nimbleparse -y original src/crimson.l src/crimson.y $< >$@

test/output/%.out: test/fail/%.crimson src/crimson.l src/crimson.y
	! nimbleparse -y original src/crimson.l src/crimson.y $< >$@

test: test/output $(test_outputs) $(test_fail_outputs)
	@echo done

test/output:
	mkdir -p $@
.PHONY: clean
clean:
	rm -f test/output/*.out
