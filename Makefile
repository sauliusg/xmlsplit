#---*- Makefile -*-------------------------------------------------------
#$Author$
#$Date$
#$Revision$
#$URL$
#------------------------------------------------------------------------

MAKECONF_FILES = $(sort \
	$(filter-out %.example, $(filter-out %~, $(wildcard Makeconf*))) \
	$(patsubst %.example, %, $(wildcard Make*.example)))

ifneq ("${MAKECONF_FILES}","")
include ${MAKECONF_FILES}
endif

TEST_DIR = tests/cases
OUTP_DIR = tests/outputs

# The folowing variable MUST be terminated with "/" if it is not empty:
SCRIPT_DIR = ./

TEST_CASES_INP = $(wildcard ${TEST_DIR}/*.inp)
TEST_CASES_OPT = $(wildcard ${TEST_DIR}/*.opt)
TEST_CASES_SH  = $(wildcard ${TEST_DIR}/*.sh)

OUTPUTS = $(sort \
	${TEST_CASES_INP:${TEST_DIR}/%.inp=${OUTP_DIR}/%.out} \
	${TEST_CASES_OPT:${TEST_DIR}/%.opt=${OUTP_DIR}/%.out} \
	${TEST_CASES_SH:${TEST_DIR}/%.sh=${OUTP_DIR}/%.out})

DIFFS   = ${OUTPUTS:%.out=%.diff}

.PHONY: all test tests out outputs clean cleanAll distclean

all: tests

#------------------------------------------------------------------------------

tests test: ${DIFFS} lib/perl5/XMLSplit/Version.pm

${OUTP_DIR}/%.diff: ${TEST_DIR}/%.inp ${OUTP_DIR}/%.out
	@printf "%-30s: " $*
	@${SCRIPT_DIR}$(shell echo $* | sed -e 's/_[0-9]*$$//') $< 2>&1 \
	| diff -I '^# Id: ' $(lastword $^) - > $@; \
	if [ $$? -eq 0 ]; then \
		echo OK; \
	else \
		echo FAILED:; cat $@; \
	fi

${OUTP_DIR}/%.diff: ${TEST_DIR}/%.sh ${OUTP_DIR}/%.out
	@printf "%-30s: " $*
	@$< 2>&1 | diff -I '^# Id: ' $(lastword $^) - > $@; \
	if [ $$? -eq 0 ]; then \
		echo OK; \
	else \
		echo FAILED:; cat $@; \
	fi

${OUTP_DIR}/%.diff: ${TEST_DIR}/%.opt ${OUTP_DIR}/%.out
	@printf "%-30s: " $*
	@${SCRIPT_DIR}$(shell echo $* | sed -e 's/_[0-9]*$$//') \
		$(shell grep -v "^#" $<) 2>&1 \
	| diff -I '^# Id: ' $(lastword $^) - > $@; \
	if [ $$? -eq 0 ]; then \
		echo OK; \
	else \
		echo FAILED:; cat $@; \
	fi

out outputs: ${OUTPUTS}

${OUTP_DIR}/%.out: ${TEST_DIR}/%.inp
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
		${SCRIPT_DIR}$(shell echo $* | sed -e 's/_[0-9]*$$//') $< 2>&1 \
		| tee $@
	-@touch $@

${OUTP_DIR}/%.out: ${TEST_DIR}/%.sh
	-@test -f $@ || echo "$@:"
	-@test -f $@ || $< 2>&1 | tee $@
	-@touch $@

${OUTP_DIR}/%.out: ${TEST_DIR}/%.opt
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
		${SCRIPT_DIR}$(shell echo $* | sed -e 's/_[0-9]*$$//') \
			$(shell grep -v "^#" $<) 2>&1 \
		| tee $@
	-@touch $@

#------------------------------------------------------------------------------

MAKELOCAL_FILES = ${filter-out %~, ${wildcard Makelocal*}}

ifneq ("${MAKELOCAL_FILES}","")
include ${MAKELOCAL_FILES}
endif

Make%: Make%.example
	test -f $@ || cp $< $@
	test -f $@ && touch $@

#------------------------------------------------------------------------------

.PHONY: failed listdiff

failed listdiff:
	@find ${OUTP_DIR} -type f -name '*.diff' -size +0 | sort -u

#------------------------------------------------------------------------------

clean:
	rm -f ${DIFFS}

cleanAll distclean: clean
