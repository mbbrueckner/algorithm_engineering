CXX = g++-16
CXXFLAGS = -fopenmp
OPTFLAGS = -Ofast

BUILD_DIR = build
TARGETS = $(BUILD_DIR)/pi_monte_carlo $(BUILD_DIR)/pi_monte_carlo_omp $(BUILD_DIR)/pi_monte_carlo_omp_v2
OPT_TARGETS = $(BUILD_DIR)/pi_monte_carlo_ofast $(BUILD_DIR)/pi_monte_carlo_omp_ofast $(BUILD_DIR)/pi_monte_carlo_omp_ofast_v2

.PHONY: all clean

all: $(TARGETS) $(OPT_TARGETS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/pi_monte_carlo: pi_monte_carlo.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/pi_monte_carlo_ofast: pi_monte_carlo.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) $< -o $@

$(BUILD_DIR)/pi_monte_carlo_omp: pi_monte_carlo_omp.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/pi_monte_carlo_omp_ofast: pi_monte_carlo_omp.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) $< -o $@

$(BUILD_DIR)/pi_monte_carlo_omp_v2: pi_monte_carlo_omp_v2.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

$(BUILD_DIR)/pi_monte_carlo_omp_ofast_v2: pi_monte_carlo_omp_v2.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) $(OPTFLAGS) $< -o $@

clean:
	rm -rf $(BUILD_DIR)
