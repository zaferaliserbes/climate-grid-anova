# Climate Grid ANOVA

This MATLAB project performs a 3-way ANOVA (Analysis of Variance) on climate model outputs distributed over spatial grid points. The analysis helps quantify the contribution of key experimental factors—**Model**, **Scenario**, and **Coefficient**—to the variability in each grid's predicted values.

## 📁 What This Repository Contains

* `anova_climate_grid.m` — Main MATLAB script that:

  * Loads a grid-based dataset from a `.mat` file.
  * Extracts grid data and descriptive factors.
  * Performs ANOVA with interaction terms.
  * Computes and displays variance contributions.
  * Plots results using a bar chart.

## 📊 ANOVA Factors

The script uses the following as categorical variables:

* **Model** — Climate model type
* **Scenario** — Emissions or climate scenario
* **Coefficient** — Parameter configuration or calibration label

Each grid cell (e.g., `Grid_1`, `Grid_2`, ..., `Grid_N`) is analyzed independently, and the contribution of each factor (including interactions) is reported.

## 📝 Data Format

The input `.mat` file must contain a variable named `climate_grid_data` structured as a cell array with columns:

| Column   | Description               |
| -------- | ------------------------- |
| 1        | Year                      |
| 2 to N-3 | Grid values (Grid\_1 ...) |
| N-2      | Model name                |
| N-1      | Scenario                  |
| N        | Coefficient               |

## 🔧 How to Use

1. Clone the repository.
2. Set your file path and file name in the script:

```matlab
base_path = '';     % <-- Insert your folder path
data_file = '';     % <-- Insert your .mat file name
```

3. Ensure the `.mat` file contains `climate_grid_data` in the required format.
4. Run the script in MATLAB.
5. View the ANOVA table and variance contribution plot for the selected grid.

## 📌 Note

* The current version runs ANOVA for a single selected grid (`Grid_1`).
* Future versions will include a loop to process all grids automatically and export results.

---

## 📄 License

This project is released under the Zafer Ali Serbes License.

