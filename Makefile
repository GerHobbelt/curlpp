BUILD_DIR ?= ../xl
include $(BUILD_DIR)/makefile.d/base.mk

CXXFLAGS += -Iinclude -std=c++14

# Fall back to OUTPUT_DIR. Keeps this build working if there is a mismatch with the xl repo.
LIBRARY_OUTPUT_DIR ?= $(OUTPUT_DIR)

CURLPP_A = $(LIBRARY_OUTPUT_DIR)/libcurlpp.a

HEADERS = $(shell find . -name "*.h")

OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/Easy.o
OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/Form.o
OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/Multi.o
OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/Options.o
OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/Exception.o
OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/Info.o
OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/OptionBase.o
OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/cURLpp.o
OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/internal/CurlHandle.o
OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/internal/OptionList.o
OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/internal/OptionSetter.o
OBJS += $(LIBRARY_OUTPUT_DIR)/curlpp/internal/SList.o

$(LIBRARY_OUTPUT_DIR):
	$(VERBOSE)mkdir -p $(LIBRARY_OUTPUT_DIR)

$(LIBRARY_OUTPUT_DIR)/%.o: src/%.cpp $(HEADERS) | $(LIBRARY_OUTPUT_DIR)
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(PROFILE_FLAGS) -c $< -o $@

$(CURLPP_A): $(HEADERS) $(OBJS) | $(LIBRARY_OUTPUT_DIR)
	$(AR) src $(CURLPP_A) $(OBJS)

clean:
	rm -rf $(LIBRARY_OUTPUT_DIR)

all: $(CURLPP_A)
