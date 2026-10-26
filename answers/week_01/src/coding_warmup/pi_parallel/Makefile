CXX = g++-16
CXXFLAGS = -fopenmp
OPTFLAGS = -Ofast

BUILD_DIR = build
SOURCES = pi_numerical_integration.cpp pi_openmp_v1.cpp pi_openmp_v2.cpp pi_openmp_v3.cpp
TARGETS = $(patsubst %.cpp,$(BUILD_DIR)/%,$(SOURCES))
OPT_TARGETS = $(TARGETS:%=%_ofast)

.PHONY: all clean

all: $(TARGETS) $(OPT_TARGETS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/pi_numerical_integration: pi_numerical_integration.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/pi_numerical_integration_ofast: pi_numerical_integration.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) $< -o $@

$(BUILD_DIR)/pi_openmp_v1: pi_openmp_v1.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/pi_openmp_v1_ofast: pi_openmp_v1.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) $< -o $@

$(BUILD_DIR)/pi_openmp_v2: pi_openmp_v2.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/pi_openmp_v2_ofast: pi_openmp_v2.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) $< -o $@

$(BUILD_DIR)/pi_openmp_v3: pi_openmp_v3.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/pi_openmp_v3_ofast: pi_openmp_v3.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) $< -o $@

clean:
	rm -rf $(BUILD_DIR)
