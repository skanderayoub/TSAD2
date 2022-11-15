# Computation time
---
This feature returns the average computation time (in seconds) for a single timetsep prediction on each trained DNN.

### Steps
---
1. Select a dataset and preprocess the data.
2. Select and tune one or multiple DNNs and train them.
2. On the detection tab, select a faulty data and run the detection for all trained models.
3. Select the "Computation time" pannel.

**Features:**
* The window displays a table with:
    * the trained DNN models,
    * the average computation time of each model,
    * the metric scores on the selected faulty data for a given thresholding method.
* The thresholding method can be changed and the scores will refresh in the table accordingly.
* The table content can be exported as a .csv file
* In addition, the user can choose to display certain metric scores according to the computation time of the models in order to better estimate their value during a deployment for real-time detection.

# Simulink detection
---










